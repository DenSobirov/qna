FactoryBot.define do
  factory :user do
    email { "em#{Time.now.to_f}@com.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
