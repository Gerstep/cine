def length_at_least(count)
  begin
    result = yield
  end while result.length < count
  result
end

FactoryGirl.define do
  factory :user do
    email       { Faker::Internet.email }
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    password    { Faker::DizzleIpsum.words(4).join('!').first(20) }
  end

  factory :authentication do
    association :user
    provider { %w[twitter facebook linkedin].sample }
    proid { SecureRandom.hex }
    token {
      t = SecureRandom.hex
      t[8] = '-'
      t
    }
  end
end