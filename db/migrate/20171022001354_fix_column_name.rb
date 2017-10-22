class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :expenses, :type, :type_id
  end
end
