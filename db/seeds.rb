# Add some groupss
5.times do
  Group.create(name: Faker::Company.name,
               email: Faker::Internet.email,
               password: 'secret',
               password_confirmation: 'secret')
end

# Add associated objects inside groups
Group.all.each do |group|

  # Add members
  (1..4).to_a.sample.times do
    members = group.members.create(name: Faker::Name.name,
                         email: Faker::Internet.free_email)
  end

  # Add a todo list
  group.todo_lists.create(name: Faker::Hipster.words(2).join(' '),
                          description: Faker::Hipster.paragraph,
                          notifications_enabled: [true, false].sample)


  # Add todo items
  (2..8).to_a.sample.times do
    todo_item = group.todo_lists.first.todo_items.create(name: Faker::Hipster.sentence((1..3).to_a.sample),
                                                         description: Faker::Hipster.paragraph,
                                                         start_date: Date.today,
                                                         end_date: Date.today + 1.days )
    members = group.members
    todo_item.members = members.take (1..members.count).to_a.sample
  end
end
