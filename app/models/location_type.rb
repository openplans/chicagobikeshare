class LocationType < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :feature_points_location_types
  has_many :feature_points, :through => :feature_points_location_types
end
