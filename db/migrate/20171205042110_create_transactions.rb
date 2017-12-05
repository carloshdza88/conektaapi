class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :numcuenta
      t.float :deposito
      t.float :retiro
      t.float :saldo

      t.timestamps
    end
  end
end
