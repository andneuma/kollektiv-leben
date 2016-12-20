class TodoItem < ActiveRecord::Base
  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 40 }
  validates_date :start_date
  validates_date :end_date, after: :start_date
end
