require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'should have valid factory' do
    expect(FactoryGirl.build(:post)).to be_valid
  end

  it 'should require media or content' do
    expect(FactoryGirl.build(:post, media: '', content: '')).to be_invalid
  end

  it 'should be valid with only media' do
    expect(FactoryGirl.build(:post, content: '')).to be_valid
  end

  it 'should be valid with only content' do
    expect(FactoryGirl.build(:post, media: '')).to be_valid
  end

  it 'should be valid with media content' do
    expect(FactoryGirl.build(:post)).to be_valid
  end
end
