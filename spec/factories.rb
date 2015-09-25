require 'faker'
require 'tkannounce'

FactoryGirl.define do
  factory :vendor, class: TkAnnounce::Vendor do
    name { Faker::Company.name }
    url  { Faker::Internet.url  }
  end
end
