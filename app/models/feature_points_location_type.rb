class FeaturePointsLocationType < ActiveRecord::Base
  belongs_to :feature_point
  belongs_to :location_type
end