1.upto(10){|num|
   User.find_or_initialize_by(id: num).update_attributes!(
       name: "Mr.sample#{num}",
       email: "number#{num}@seeds.com",
       password: 'password',
       password_confirmation: 'password',
       admin: true
    )
}

1.upto(10){|num|
   Label.find_or_initialize_by(id: num).update_attributes!(
       name: "number#{num}"
    )
}

1.upto(10){|num|
   Task.find_or_initialize_by(id: num).update_attributes!(
       name: "task_number#{num}",
       content: "task_content#{num}",
       dead_line: '2020-07-01 00:00:00',
       status: '未着手',
       priority: 2,
       user_id: 1
    )
}
