require 'faker'

FactoryGirl.define do

  factory :vendor do
    name { Faker::Company.name }
    url  { Faker::Internet.url  }
  end

end
