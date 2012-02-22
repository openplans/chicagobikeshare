class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.integer :start_id, :end_id
      t.timestamps
    end
  end
end
