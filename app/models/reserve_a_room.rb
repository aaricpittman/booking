class ReserveARoom
  include ActiveModel::Model

  attr_accessor :user, :check_in, :check_out, :hotel_id, :room_type_id,
                :description, :stripe_token

  validates :check_in, :check_out, :stripe_token, presence: true
  validates :hotel_id, presence: { message: "You must select a hotel." }
  validates :room_type_id, presence: {
      message: "You must select a room type.",
      if: Proc.new { |r| r.hotel_id.present? }
    }

  def initialize(attributes = {})
    set_date_attributes(attributes)
    if attributes.present?
      attributes.each do |attribute, value|
        send(:"#{attribute}=", value)
      end
    end
  end

  def hotel
    @hotel ||= Hotel.find(hotel_id)
  end

  def room_type
    @room_type ||= RoomType.find(room_type_id)
  end

  def room
    @room ||= hotel.rooms
      .by_type(room_type.id)
      .available_on(check_in, check_out)
      .first
  end

  def booking
    @booking ||= Booking.new(booking_params)
  end

  def persisted?
    false
  end

  def set_date_attributes(attributes)
    self.check_in = Date.parse(attributes.delete(:check_in)) if attributes[:check_in].present?
    self.check_out = Date.parse(attributes.delete(:check_out)) if attributes[:check_out].present?
  end

  def save
    if valid?
      begin
        save!
      rescue ActiveRecord::RecordNotSaved => e
        false
      end
    else
      false
    end
  end

  private

  def booking_params
    {
      user_id: user.id,
      room_id: room.id,
      check_in: check_in,
      check_out: check_out,
      description: description,
      total_cents: calculate_total
    }
  end

  def charge_credit_card
    begin
      charge = Stripe::Charge.create(
        amount: booking.total_cents,
        currency: "usd",
        source: stripe_token,
        description: description_for_stripe
      )

      booking.charge_id = charge.id
      true
    rescue Stripe::CardError => e
      errors.add(:base, "Credit card was declined.")
      false
    end
  end

  def save!
    booking.save if charge_credit_card
  end

  def number_of_nights
    (check_out.to_date - check_in.to_date).to_i
  end

  def calculate_total
    room_type.rate_cents * number_of_nights
  end

  def description_for_stripe
    "#{number_of_nights} nights at #{hotel.name} in a #{room_type.name} room"
  end
end
