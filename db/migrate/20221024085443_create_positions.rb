class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.string :name
      t.text :position_access
      t.references :company

      t.timestamps
    end
  end
end
