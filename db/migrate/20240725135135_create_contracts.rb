class CreateContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :contracts do |t|
      t.integer :user_id
      t.integer :gaji_pokok
      t.integer :tunjangan_jabatan
      t.integer :tunjangan_makan
      t.integer :tunjangan_transport
      t.integer :tunjangan_laptop
      t.integer :bpjs_kesehatan
      t.integer :bpjs_ketenagakerjaan
      t.integer :pph_21

      t.timestamps
    end
  end
end
