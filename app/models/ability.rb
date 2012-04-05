# Abilities determine what actions a user can take on specified models. 
# You can read up on how to set these abilities on the cancan wiki:
# https://github.com/ryanb/cancan/wiki

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, :all
    
    if user.is_a? Admin
      can :access, :rails_admin
      can :manage, :all
      
      # Only super admins can create and edit site options & admins
      unless user.role? :superadmin
        cannot :manage, SiteOption
        cannot :manage, Admin
      end
    else
      if SiteOption.read_only?
        cannot :read, FeaturePoint
        return
      end
      
      can :create, FeaturePoint
      can :create, Comment
      can :manage, Vote
    end
  end
end
