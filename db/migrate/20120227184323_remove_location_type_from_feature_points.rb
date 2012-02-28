class RemoveLocationTypeFromFeaturePoints < ActiveRecord::Migration
  def up
    remove_column :feature_points, :location_type_id
  end

  def down
    add_column :feature_points, :location_type_id, :integer
  end
end
