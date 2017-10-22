class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :type
      t.decimal :amount
      t.string :comment

      t.timestamps
    end
  end
end
