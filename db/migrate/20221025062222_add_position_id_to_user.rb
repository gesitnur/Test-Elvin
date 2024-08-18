class AddPositionIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :position, index: true
  end
end
