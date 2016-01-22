require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'should require a username' do
    expect(FactoryGirl.build(:user, username: '')).to be_invalid
  end

  it 'should require a name' do
    expect(FactoryGirl.build(:user, name: '')).to be_invalid
  end
end
