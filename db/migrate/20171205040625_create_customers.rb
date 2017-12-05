class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :nombre
      t.integer :numcuenta

      t.timestamps
    end
  end
end
