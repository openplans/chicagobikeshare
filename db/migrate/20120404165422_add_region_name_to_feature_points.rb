class AddRegionNameToFeaturePoints < ActiveRecord::Migration
  def change
    add_column :feature_points, :region_name, :string
    
    FeaturePoint.find_each do |feature_point|
      feature_point.update_attribute :region_name, feature_point.region.try(:name)
    end
  end
end
