require 'spec_helper'

describe Project do
  let(:project) { FactoryGirl.build(:project) }

  it 'is valid when created with valid data' do
    expect(project).to be_valid
  end

  it 'is invalid when created without a code' do
    expect(FactoryGirl.build(:project, code: nil)).to have(1).error_on(:code)
  end

  it 'is invalid when created without a client' do
    expect(FactoryGirl.build(:project, client: nil)).to have(1).error_on(:client)
  end

  it 'delegates client_name to the client' do
    expect(project.client_name).to eq(project.client.name)
  end

  it 'delegates client_address to the client' do
    expect(project.client_address).to eq(project.client.address)
  end
end
