FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { 'common' }

    trait :admin do
      role { 'admin' }
    end
  end
end
