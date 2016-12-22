class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :email
      t.string :name
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
