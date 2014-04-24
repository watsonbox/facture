FactoryGirl.define do
  factory :line_item do
    sequence(:description) { |n| "Line item #{n}" }
    quantity 1
    price 9.99
  end
end
