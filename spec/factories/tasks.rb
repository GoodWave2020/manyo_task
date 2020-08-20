FactoryBot.define do
  factory :task do
    name { 'test_name' }
    content { 'test_content' }
    dead_line { DateTime.now }
  end
end
