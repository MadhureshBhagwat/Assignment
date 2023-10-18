class CreatePersonalData < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_data do |t|
      t.string :first_name, limit: 25, null: false
      t.string :last_name, limit: 50, null: false
      t.string :nickname
      t.string :email, null: false
      t.string :phone_number, null: false

      t.timestamps
    end

    add_index :personal_data, :email, unique: true
  end
end
