FactoryGirl.define do
  factory :invoice do
    reference 'SERV/AP1/001'
    currency 'EUR'
    date { Time.now }
    association :project

    factory :invoice_with_line_items do
      ignore do
        line_item_count 5
      end

      after(:build) do |invoice, evaluator|
        invoice.line_items = create_list(:line_item, evaluator.line_item_count, invoice: invoice)
      end
    end
  end
end
