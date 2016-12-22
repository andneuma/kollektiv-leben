class Member < ActiveRecord::Base
  belongs_to :group

  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 40 }
end
