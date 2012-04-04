# A FeatureRegion joins map features to Regions. Currently, only FeaturePoints 
# can be associated with a Region. FeatureRegions are created: 1- after a new
# FeaturePoint is created, 2- When a new Shapefile is uploaded by an admin.

class FeatureRegion < ActiveRecord::Base

  belongs_to :feature, :polymorphic => true
  belongs_to :region 
  
  after_create :update_feature_point_region_name
  
  private
  
  def update_feature_point_region_name
    if region.default? || feature.region_name.blank?
      feature.update_attribute :region_name, region.name
    end
  end
  
end
