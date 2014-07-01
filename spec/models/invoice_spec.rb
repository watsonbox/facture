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

  describe '#subtotal_in_default_currency' do
    it 'correctly converts to the default currency when an exchange rate is available' do
      expect(Money.default_currency).to eq 'EUR'

      invoice = build(:invoice_with_line_items, :currency => 'GBP', :default_currency_exchange_rate => 1.22)

      expect(invoice.subtotal_in_default_currency.to_d).to eq 60.93
    end
  end

  describe '#attributes_with_line_items=' do
    it 'can be created with line_items' do
      project = create(:project)

      invoice = Invoice.new
      invoice.attributes_with_line_items = params(project.id)
      invoice.save

      expect(invoice).to be_valid
      expect(invoice.line_items.length).to eq(1)
    end

    it 'saves modified line items' do
      project = create(:project)
      invoice = create(
        :invoice,
        reference: "INVBB-001",
        date: "Fri, 04 Apr 2014 00:00:00 GMT",
        currency: "GBP",
        project: project,
        line_items: [
          build(:line_item, description: "Description 2", price: 10, quantity: 2, invoice_id: "1")
        ]
      )

      expect(invoice.line_items.length).to eq(1)
      expect(invoice.line_items.first.description).to eq("Description 2")

      invoice.attributes_with_line_items = params(project.id)
      invoice.save

      expect(invoice).to be_valid
      expect(invoice.line_items.length).to eq(1)
      expect(invoice.line_items.first.description).to eq("Description 1")
    end

    it 'reports validation errors correctly for invalid modified line items' do
      project = create(:project)
      invoice = create(
        :invoice,
        reference: "INVBB-001",
        date: "Fri, 04 Apr 2014 00:00:00 GMT",
        currency: "GBP",
        project: project,
        line_items: [
          build(:line_item, description: "Description 2", price: 10, quantity: 2, invoice_id: "1")
        ]
      )

      expect(invoice.line_items.length).to eq(1)
      expect(invoice.line_items.first.description).to eq("Description 2")

      invoice.attributes_with_line_items = invalid_params(project.id)
      invoice.save

      expect(invoice).not_to be_valid
      expect(invoice.errors.full_messages).to eq ["Reference can't be blank", "Line items description can't be blank"]
    end

    it 'destroys removed line items' do
      project = create(:project)
      invoice = create(
        :invoice,
        reference: "INVBB-001",
        date: "Fri, 04 Apr 2014 00:00:00 GMT",
        currency: "GBP",
        project: project
      )

      invoice.attributes_with_line_items = params(project.id)
      invoice.save

      expect(invoice).to be_valid
      expect(invoice.line_items.length).to eq(1)
    end

    it 'creates added line items' do
      project = create(:project)
      invoice = create(:invoice, reference: "INVBB-001", date: "Fri, 04 Apr 2014 00:00:00 GMT", currency: "GBP", project: project)

      expect(invoice.line_items).to be_empty

      invoice.attributes_with_line_items = params(project.id)
      invoice.save

      expect(invoice).to be_valid
      expect(invoice.line_items.length).to eq(1)
    end

    def params(project_id)
      {
        "reference" => "INVBB-001",
        "date" => "Fri, 04 Apr 2014 00:00:00 GMT",
        "currency" => "GBP",
        "project_id" => project_id,
        "line_items" => [
          { "description" => "Description 1", "price" => 10, "quantity" => 2, "invoice_id" => "1", "id" => nil }
        ]
      }
    end

    def invalid_params(project_id)
      {
        "reference" => "",
        "date" => "Fri, 04 Apr 2014 00:00:00 GMT",
        "currency" => "GBP",
        "project_id" => project_id,
        "line_items" => [
          { "description" => "", "price" => 10, "quantity" => 2, "invoice_id" => "1", "id" => nil }
        ]
      }
    end
  end
end
