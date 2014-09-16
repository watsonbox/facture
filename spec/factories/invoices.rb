FactoryGirl.define do
  factory :invoice do
    reference 'SERV/AP1/001'
    currency 'EUR'
    date { Time.now }
    association :project

    # Nice overview of using traits: http://cookieshq.co.uk/posts/useful-factory-girl-methods/
    trait :with_line_items do
      ignore do
        # Note used in factory creation - can be set when creating invoice
        # e.g. create(:invoice, :with_line_items, line_item_count: 10)
        line_item_count 5
      end

      after(:build) do |invoice, evaluator|
        invoice.line_items = create_list(:line_item, evaluator.line_item_count, invoice: invoice)
      end
    end
  end
end
