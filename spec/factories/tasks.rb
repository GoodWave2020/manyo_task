FactoryBot.define do
  factory :task do
    name { 'test_name' }
    content { 'test_content' }
    dead_line { '2020-07-01 00:00:00' }
    status { '未着手' }
    priority { 2 }
  end
end
