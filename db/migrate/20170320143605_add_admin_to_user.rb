class AddAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, null: false, default: false
    change_column :users, :newsletter, :string, :default => "Subscribe"
    change_column :events, :status, :string, :default => "Pending"
  end
end
