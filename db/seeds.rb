9.times do |n|
  User.create!(name: "Mr.sample#{n}",
               email: "number#{n}@seeds.com",
               password: 'password',
               password_confirmation: 'password',
               admin: false
               )
end

User.create!(name: "Mr.admin",
             email: "admin@admin.com",
             password: 'password',
             password_confirmation: 'password',
             admin: true
             )

10.times do |n|
  Label.create!(name: "number#{n}")
end

10.times do |n|
   Task.create!(name: "task_number#{n}",
                content: "task_content#{n}",
                dead_line: '2020-07-01 00:00:00',
                status: '未着手',
                priority: 2,
                user_id: User.find_by(name: 'Mr.sample1').id
                )
end
