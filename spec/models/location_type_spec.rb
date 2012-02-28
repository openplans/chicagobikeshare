require 'spec_helper'

describe LocationType do
  describe "associations" do
    attr_reader :location_type
    
    before do
      @location_type = create_location_type
    end
    
    context "features" do
      attr_reader :feature_point
      
      before do
        @feature_point = create_feature_point
        feature_point.location_types << location_type
      end
      
      it "has_many" do
        location_type.feature_points.should include(feature_point)
      end
    end
  end
  
  describe "validations" do
    context "with no name" do
      attr_reader :location_type
      
      before do
        @location_type = new_location_type :name => nil
        location_type.valid?
      end
      
      it "is invalid" do
        @location_type.should_not be_valid
      end
      
      it "has errors on name" do
        @location_type.errors[:name].should be
      end
    end
  end
end
