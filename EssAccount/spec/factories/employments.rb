FactoryBot.define do
  factory :employment do
    employer { Faker::Company.name }
    date_started { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    date_ended { Faker::Date.between(from: 1.year.ago, to: Date.today) }
    personal_data
  end
end
