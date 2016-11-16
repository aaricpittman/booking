require 'rails_helper'

RSpec.describe User, '#roles_to_sym', type: :model do
  let(:subject) { create(:user) }

  before(:each) do
    roles = double('roles', pluck: ['tester','admin','user'])
    allow(subject).to receive(:roles).and_return(roles)
  end

  it "should return the users roles as an array of symbols" do
    expect(subject.roles_to_sym).to eq [:tester, :admin, :user]
  end
end

RSpec.describe User, '#in_role?', type: :model do
  let(:subject) { create(:user) }

  before(:each) do
    roles = double('roles', pluck: ['tester','admin','user'])
    allow(subject).to receive(:roles).and_return(roles)
  end

  it "should return true if parameter is in list of roles" do
    expect(subject.in_role?(:admin)).to be true
  end

  it "should return false if parameter is not in the list of roles" do

  end
end
