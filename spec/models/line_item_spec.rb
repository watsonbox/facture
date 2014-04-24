require 'spec_helper'

describe LineItem do
  let(:line_item) { FactoryGirl.build(:line_item) }

  it 'is valid when created with valid data' do
    expect(line_item).to be_valid
  end

  it 'is invalid when created without a description' do
    expect(FactoryGirl.build(:line_item, description: nil)).to have(1).error_on(:description)
  end

  it 'is invalid when created without a price' do
    expect(FactoryGirl.build(:line_item, price: nil)).to have(1).error_on(:price)
  end
end
