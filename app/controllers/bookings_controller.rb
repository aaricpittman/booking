class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
  end

  def new
    get_hotels
    @reserve_a_room = ReserveARoom.new
  end

  def create
    @reserve_a_room = ReserveARoom.new(params[:reserve_a_room])
    @reserve_a_room.user = current_user

    if @reserve_a_room.valid?
      if @reserve_a_room.save
        flash[:success] = "Your room has been booked!"
        redirect_to root_path
        return
      end
    end

    get_hotels
    render :new
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
