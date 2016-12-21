FactoryGirl.define do
  factory :todo_item do
    name 'SomeTodo'
    description 'SomethingTodo'
    start_date { Date.today }
    end_date { Date.today + 1 }
    todo_list

    trait :completed do
      completed true
    end
  end
end
