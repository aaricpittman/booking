require 'rails_helper'

RSpec.describe ReserveARoom, 'validations', type: :model do
  it { should validate_presence_of(:check_in) }
  it { should validate_presence_of(:check_out) }
  it { should validate_presence_of(:stripe_token) }
  it { should validate_presence_of(:hotel_id).with_message("You must select a hotel.") }

  context "hotel id is present" do
    let(:subject) { ReserveARoom.new({hotel_id: 1}) }
    it { should validate_presence_of(:room_type_id).with_message("You must select a room type.") }
  end

  context "hotel id is not present" do
    it { should_not validate_presence_of(:room_type_id) }
  end
end

RSpec.describe ReserveARoom, '#save', type: :model do
  context "invalid data" do
    let(:reserve_a_room) { ReserveARoom.new({}) }

    it "should return false" do
      expect(reserve_a_room.save).to be false
    end

    it "should have the error messages" do
      reserve_a_room.save
      expect(reserve_a_room.errors.empty?).to be false
    end
  end

  context "with valid data" do
    let(:user) { double('user', id: 1) }
    let(:hotel) { double('hotel', id: 1, name: 'The Ritz') }
    let(:room_type) { double('room_type', id: 1, name: 'King', rate_cents: 19999) }
    let(:subject) { ReserveARoom.new({
      user: user,
      check_in: Time.now.to_date.to_s,
      check_out: 3.days.from_now.to_date.to_s,
      hotel_id: 1,
      room_type_id: 1,
      stripe_token: 'abc123'
    })}

    before(:each) do
      allow(subject).to receive(:hotel) { hotel }
      allow(subject).to receive(:room) { double('room', id: 1) }
      allow(subject).to receive(:room_type) { room_type }
    end

    it "should return true" do
      allow(Stripe::Charge).to receive(:create) { double('charge', id: 123) }
      expect(subject.save).to be true
    end

    it "should charge their card" do
      expect(Stripe::Charge).to receive(:create).with({
        amount: 59997,
        currency: "usd",
        source: "abc123",
        description: "3 nights at #{hotel.name} in a #{room_type.name} room"
      }) { double('charge', id: 123) }
      subject.save
    end

    it "should create the booking" do
      allow(Stripe::Charge).to receive(:create) { double('charge', id: 123) }
      expect{ subject.save }.to change{ Booking.count }.by(1)
    end
  end
end
