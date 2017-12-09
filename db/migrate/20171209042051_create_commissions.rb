class CreateCommissions < ActiveRecord::Migration[5.1]
  def change
    create_table :commissions do |t|
      t.float :montominimo
      t.float :montomaximo
      t.float :porcentaje
      t.float :tasafija
      t.string :descripcion

      t.timestamps
    end
  end
end
