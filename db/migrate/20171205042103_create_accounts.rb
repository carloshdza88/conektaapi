class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :numtarjeta
      t.integer :tipotarjeta
      t.float :saldo

      t.timestamps
    end
  end
end
