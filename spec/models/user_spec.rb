require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }

  # An user should indeed have many recipes!
  it { should have_many(:recipes) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
end
