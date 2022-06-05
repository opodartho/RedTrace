class AddCompanyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :company, index: true, null: false, default: 1
  end
end
