class CreateEmployments < ActiveRecord::Migration[7.0]
  def change
    create_table :employments do |t|
      t.string :employer, null: false
      t.date :date_started, null: false
      t.date :date_ended, null: false
      t.references :personal_data, null: false, foreign_key: true

      t.timestamps
    end
  end
end
