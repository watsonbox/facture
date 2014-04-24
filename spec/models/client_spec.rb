require 'spec_helper'

describe Client do
  let(:client) { build(:client) }

  it 'is valid when created with valid data' do
    expect(client).to be_valid
  end

  it 'is invalid when created without a name' do
    expect(build(:client, name: nil)).to have(1).error_on(:name)
  end
end
