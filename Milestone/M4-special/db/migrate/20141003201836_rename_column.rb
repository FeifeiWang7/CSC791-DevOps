class RenameColumn < ActiveRecord::Migration
  def change
    remove_column :jobs, :employer_name
    rename_column :jobs, :employer, :employer_name
  end
end
