FactoryBot.define do
  factory :user do
    sequence(:nickname) {|n| "NICKNAME#{n}"}
    profile {"プロフィールプロフィールプロフィール"}
    sequence(:email) {|n| "sample#{n}@example.com"}
    password {"password"}
    password_confirmation {"password"}
    role {1}
  end
end
