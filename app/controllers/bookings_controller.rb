class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
  end

  def new
    get_hotels
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.new(booking_params)

    return if dates_arent_picked_yet?

    unless params[:hotel_id].present?
      render_new "You must select a hotel."
      return
    end

    @hotel = Hotel.find(params[:hotel_id])

    unless params[:room_type_id].present?
      render_new("You must select a room type.")
      return
    end

    @room_type = RoomType.find(params[:room_type_id])

    @room = @hotel.rooms
      .by_type(@room_type.id)
      .available_on(@booking.check_in, @booking.check_out)
      .first

    if @room.present?
      @booking.room = @room

      if @booking.save
        flash[:success] = "Your room has been booked!"
        redirect_to root_path
      else
        render_new "I am here!"
      end
    else
      render_new "Room is no longer available for those dates."
    end
  end

  private

  def get_hotels
    @hotels = Hotel.order(:name)
  end

  def dates_arent_picked_yet?
    if (!@booking.valid? &&
        @booking.errors.added?(:check_in, :blank) &&
        @booking.errors.added?(:check_out, :blank))
      @booking.errors.delete(:room_id)
      render_new
      true
    else
      false
    end
  end

  def render_new(error_message = nil)
    get_hotels
    flash[:danger] = error_message if error_message
    render :new
  end

  def booking_params
    params.require(:booking).permit(
      :room_id,
      :description,
      :check_in,
      :check_out
    )
  end
end
