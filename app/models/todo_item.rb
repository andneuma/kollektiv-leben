class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  has_many :members, through: :members_todo_items

  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 40 }
  validates_date :start_date
  validates_date :end_date, after: :start_date
end
