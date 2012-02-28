class DropFeatureLocationTypes < ActiveRecord::Migration
  def up
    drop_table :feature_location_types
  end

  def down
    create_table "feature_location_types", :force => true do |t|
      t.integer  "feature_id"
      t.integer  "location_type_id"
      t.string   "feature_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
