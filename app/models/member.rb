class Member < ActiveRecord::Base
  belongs_to :group
  has_many :todo_items, through: :member_todo_items
  has_many :member_todo_items

  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 40 }
end
