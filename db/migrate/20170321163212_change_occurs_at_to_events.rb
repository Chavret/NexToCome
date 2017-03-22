class ChangeOccursAtToEvents < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :occurs_at, :date
  end
end
