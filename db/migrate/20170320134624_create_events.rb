class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.datetime :occurs_at
      t.string :headline
      t.string :headline_initial
      t.references :sub_category, foreign_key: true
      t.integer :rating
      t.string :source
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
