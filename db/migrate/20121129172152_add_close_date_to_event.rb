class AddCloseDateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :close_date, :datetime
  end
end
