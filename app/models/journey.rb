class Journey < ActiveRecord::Base
  belongs_to :start, :class_name => "FeaturePoint"
  belongs_to :end, :class_name => "FeaturePoint"
  
  validates :start, :presence => true
  validates :end, :presence => true
end
