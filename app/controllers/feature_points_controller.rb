class FeaturePointsController < ApplicationController

  before_filter :authenticate_admin!
  before_filter :ignore_feature_location_type_fields_if_empty, :find_or_create_profile, :update_profile, :only => :create  
  before_filter :set_cache_buster, :only => :show # for IE8
  
  def index
    authorize! :read, FeaturePoint, :message => SiteOption::PanicMessage
    
    respond_to do |format|
      format.html
      format.json do
        @feature_points = FeaturePoint.visible.where [ "id > ?", params[:after].to_i ]
        render :json => @feature_points.map(&:as_json)
      end
    end
  end
  
  def new
    authorize! :create, FeaturePoint
    
    @feature_point = FeaturePoint.new :profile => (current_profile || Profile.new)

    respond_to do |format|
      format.json { render :json => { :view => render_to_string(:partial => "form.html") } }
    end
  end
  
  def create
    authorize! :create, FeaturePoint
    
    @feature_point = FeaturePoint.new params[:feature_point].merge({
      :the_geom       => the_geom_from_params(params), 
      :submitter_name => @profile.name, 
      :profile        => @profile
    })
        
    if @feature_point.save
      find_and_store_vote @feature_point
      
      respond_to do |format|
        format.json do
          flash[:notice] = I18n.t( "feature.notice.point_added")
          render :json => { :feature_point => @feature_point.as_json, :status => "success" }
        end
      end
    else
      respond_to do |format|
        format.json do
          flash[:error] = I18n.t( "feature.notice.invalid" )
          render :json => { 
            :status => "error", 
            :view => render_to_string(:partial => "form.html.erb" ) 
          }
        end
      end
    end
  end
  
  def update
    @feature_point = FeaturePoint.find params[:id]
    authorize! :update, @feature_point
    
    @feature_point.update_attributes params[:feature_point]

    respond_to do |format|
      format.json do
        render :json => { :status => "error", :view => render_to_string(:partial => "show.html.erb", :locals => { :feature_point => @feature_point }) } 
      end
    end
  end
  
  def show
    @feature_point = FeaturePoint.visible.find params[:id], :include => :comments
    respond_to do |format|
      format.html do
        render :action => 'index'
      end
      format.json do
        render :json => { :view => render_to_string(:partial => "show.html", :locals => { :feature_point => @feature_point }) } 
      end
    end
  end
  
  def within_region
    @feature_point = FeaturePoint.new :the_geom => the_geom_from_params(params)
        
    if !@feature_point.valid? && @feature_point.errors[:the_geom].present?
      respond_to do |format|
        format.json { render :json => { :status => "error", :message => @feature_point.errors[:the_geom].join(". ") } }
      end
    else
      respond_to do |format|
        format.json { render :json => { :status => "ok" } }
      end
    end
  end
  
  private
  
  # If profile attributes have been submitted with the point, 
  # update the attributes, save profile cookie. 
  def update_profile
    profile_attributes        = params[:feature_point].delete(:profile_attributes) || {}
    profile_attributes[:name] = params[:feature_point][:submitter_name] if params[:feature_point][:submitter_name].present?
    @profile.update_attributes(profile_attributes)
    set_profile_cookie @profile
  end

  def find_and_store_vote(feature_point)
    vote = @profile.votes.where(:supportable_id => feature_point.id, :supportable_type => feature_point.class.to_s).first
    store_vote_in_cookie vote
  end
  
  def the_geom_from_params(p)
    Point.from_x_y p[:longitude].to_f, p[:latitude].to_f, 4326
  end
  
  def ignore_feature_location_type_fields_if_empty
    params[:feature_point].delete(:feature_location_type_attributes) if params[:feature_point] && params[:feature_point][:feature_location_type_attributes] && 
      params[:feature_point][:feature_location_type_attributes][:location_type_id].blank?
  end
  
end
