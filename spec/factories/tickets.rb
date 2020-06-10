FactoryBot.define do
  factory :ticket do
    department { nil }
    priority { "MyString" }
    message { "MyText" }
    subject { "MyString" }
    status { "MyString" }
    ticket_no { "MyString" }
    user { nil }
  end
end
