class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :password_digest
      t.string :password_reset_digest
      t.string :email
      t.string :activation_digest

      t.timestamps null: false
    end
  end
end
