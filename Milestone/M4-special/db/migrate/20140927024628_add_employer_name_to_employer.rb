class AddEmployerNameToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :employer_name, :string
  end
end
