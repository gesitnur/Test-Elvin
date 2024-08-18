class AddPeriodeSlipGajiToContracts < ActiveRecord::Migration[7.0]
  def change
    add_column :contracts, :periode_slip_gaji, :integer
  end
end
