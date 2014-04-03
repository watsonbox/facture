FactoryGirl.define do
  factory :project do
    name 'Acme Project 1'
    code 'AP1'
    association :client
  end
end
