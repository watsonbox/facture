require 'spec_helper'

describe Invoice do
  let(:invoice) { FactoryGirl.build(:invoice) }

  it 'is valid when created with valid data' do
    expect(invoice).to be_valid
  end

  it 'is invalid when created without a reference' do
    expect(FactoryGirl.build(:invoice, reference: nil)).to have(1).error_on(:reference)
  end

  it 'is invalid when created without a currency' do
    expect(FactoryGirl.build(:invoice, currency: nil)).to have(1).error_on(:currency)
  end

  it 'is invalid when created without a date' do
    expect(FactoryGirl.build(:invoice, date: nil)).to have(1).error_on(:date)
  end

  it 'delegates client_name to the project' do
    allow(invoice.project).to receive(:client_name).and_return(random_name = self.random_name)
    expect(invoice.client_name).to eq(random_name)
  end

  it 'delegates client_address to the project' do
    allow(invoice.project).to receive(:client_address).and_return(random_name = self.random_name)
    expect(invoice.client_address).to eq(invoice.project.client_address)
  end

  def random_name(length = 8)
    ('a'..'z').to_a.shuffle[0,length].join
  end
end
