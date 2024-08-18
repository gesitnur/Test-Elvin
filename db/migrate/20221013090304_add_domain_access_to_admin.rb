class AddDomainAccessToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :domain_access, :integer
  end
end
