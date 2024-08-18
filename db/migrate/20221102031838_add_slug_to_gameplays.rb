class AddSlugToGameplays < ActiveRecord::Migration[7.0]
  def change
    add_column :gameplays, :slug, :string
    add_index :gameplays, :slug, unique: true
  end
end
