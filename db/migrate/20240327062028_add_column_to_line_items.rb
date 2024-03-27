class AddColumnToLineItems < ActiveRecord::Migration[7.1]
  def change
    add_column :line_items, :total_price, :float 
  end
end
