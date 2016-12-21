class AddRegistrationTokensToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :registration_tokens, :string, array: true
  end
end
