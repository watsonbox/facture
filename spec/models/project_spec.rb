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
    allow(project.client).to receive(:name).and_return(random_name = self.random_name)
    expect(project.client_name).to eq(random_name)
  end

  it 'delegates client_address to the client' do
    allow(project.client).to receive(:address).and_return(random_name = self.random_name)
    expect(project.client_address).to eq(random_name)
  end

  def random_name(length = 8)
    ('a'..'z').to_a.shuffle[0,length].join
  end
end
