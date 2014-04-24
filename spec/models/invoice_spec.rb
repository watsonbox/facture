require 'spec_helper'

describe Invoice do
  let(:invoice) { build(:invoice) }

  it 'is valid when created with valid data' do
    expect(invoice).to be_valid
  end

  it 'is invalid when created without a reference' do
    expect(build(:invoice, reference: nil)).to have(1).error_on(:reference)
  end

  it 'is invalid when created without a currency' do
    expect(build(:invoice, currency: nil)).to have(1).error_on(:currency)
  end

  it 'is invalid when created without a date' do
    expect(build(:invoice, date: nil)).to have(1).error_on(:date)
  end

  it 'delegates client_name to the project' do
    allow(invoice.project).to receive(:client_name).and_return(random_name = self.random_name)
    expect(invoice.client_name).to eq(random_name)
  end

  it 'delegates client_address to the project' do
    allow(invoice.project).to receive(:client_address).and_return(random_name = self.random_name)
    expect(invoice.client_address).to eq(invoice.project.client_address)
  end

  it 'is due a month from now by default' do
    travel_to Time.now do
      expect(invoice.due_at).to eq(1.month.from_now.to_date)
    end
  end

  def random_name(length = 8)
    ('a'..'z').to_a.shuffle[0,length].join
  end

  describe '#client_name_and_address' do
    it 'is a combination of client name and address' do
      expect(invoice.client_name_and_address).to eq("Acme Corporation\n1 Road Runner Loop\nAcmeville")
    end
  end
end
