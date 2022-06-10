require 'rails_helper'

RSpec.describe Recipe, type: :model do
  
  it 'has a valid factory' do
    expect(build(:recipe1)).to be_valid
    expect(build(:recipe2)).to be_valid
  end
end
