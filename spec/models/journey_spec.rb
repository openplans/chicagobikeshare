require 'spec_helper'

describe Journey do
  describe "associations" do
    attr_reader :journey

    describe "start" do
      attr_reader :feature_point
      
      before do
        @feature_point = create_feature_point
        @journey = create_journey :start => feature_point
      end
      
      it "belongs to" do
        journey.start.should == feature_point
      end
    end
    
    describe "end" do
      attr_reader :feature_point
      
      before do
        @feature_point = create_feature_point
        @journey = create_journey :end => feature_point
      end
      
      it "belongs to" do
        journey.end.should == feature_point
      end
    end
  end
  
  describe "validations" do
    attr_reader :journey
    
    describe "start" do
      context "when absent" do
        before do
          @journey = new_journey :start => nil
        end
        
        it "is invalid" do
          journey.should_not be_valid
        end
        
        it "errors on start" do
          journey.errors[:start].should be
        end
      end
    end
    
    describe "end" do
      context "when absent" do
        before do
          @journey = new_journey :end => nil
        end
        
        it "is invalid" do
          journey.should_not be_valid
        end
        
        it "errors on start" do
          journey.errors[:end].should be
        end
      end
    end
  end
end
