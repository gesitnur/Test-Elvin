class CreateStates < ActiveRecord::Migration[7.0]
  def change
    create_table :states do |t|
      t.string :name
      t.string :code
      t.belongs_to :country

      t.timestamps
    end
  end
end
