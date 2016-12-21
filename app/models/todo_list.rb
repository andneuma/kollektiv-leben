class TodoList < ActiveRecord::Base
  has_many :todo_items, dependent: :destroy

  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 40 }
end
