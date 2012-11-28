class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :participant
      t.binary :dates_array

      t.timestamps
    end
  end
end
