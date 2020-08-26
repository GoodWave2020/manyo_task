FactoryBot.define do
  factory :user do
    name { 'test_name' }
    email { 'test@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end
  factory :admin_user, class: User do
    name { 'admin_name' }
    email { 'admin@admin.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
end
