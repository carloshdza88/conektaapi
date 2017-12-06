class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.integer :numcuenta
      t.float :fondo

      t.timestamps
    end
  end
end
