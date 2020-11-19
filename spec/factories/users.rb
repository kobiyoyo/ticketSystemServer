FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString@gmail.com" }
    password_digest { "MyString" }
    department { 1 }
    phone_no { 1 }
    role { 0 }
  end
end
