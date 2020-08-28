FactoryBot.define do
  factory :label do
    id { 1 }
    name { "MyString" }
  end
  factory :second_label, class: Label do
    id { 2 }
    name { "YourString" }
  end
end
