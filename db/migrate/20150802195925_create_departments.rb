class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :short,                            limit: 15, null: false, default: ""
      t.string :name,                             limit: 100, null: false, default: ""

      t.timestamps null: false
    end

    add_index :departments, [:short],     unique: true
    add_index :departments, [:name],     unique: true
  end
end
