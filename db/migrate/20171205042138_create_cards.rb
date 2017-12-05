class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :numtarjeta
      t.integer :tipotarjeta
      t.float :saldo

      t.timestamps
    end
  end
end
