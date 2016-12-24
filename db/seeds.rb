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
    group.members.create(name: Faker::Name.name,
                         email: Faker::Internet.free_email)
  end

  # Add a todo list
  group.todo_lists.create(name: Faker::Hipster.words(2),
                          description: Faker::Hipster.paragraph,
                          notifications_enabled: [true, false].sample)


  # Add todo items
  (1..4).to_a.sample.times do
    group.todo_lists.first.todo_items.create(name: Faker::Hipster.sentence((1..3).to_a.sample),
                                             description: Faker::Hipster.paragraph,
                                             start_date: Date.today,
                                             end_date: Date.today + 1.days )
  end
end
