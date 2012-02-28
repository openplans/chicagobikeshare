class CreateFeaturePointsLocationTypes < ActiveRecord::Migration
  create_table :feature_points_location_types, :id => false do |t|
    t.references :feature_point, :location_type
  end

  add_index :feature_points_location_types, [:feature_point_id, :location_type_id], :name => "points_types"
end
