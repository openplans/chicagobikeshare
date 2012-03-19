class LocationType < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :feature_points_location_types
  has_many :feature_points, :through => :feature_points_location_types

  has_attached_file :image, :styles => { :small => "32x32>", :icon => "16x16>" }
  
end
