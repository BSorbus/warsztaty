class SurveyPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user_activities.include? 'survey:index'
  end

  def index_self?
    user_activities.include? 'survey:index_self'
  end

  def show?
    user_activities.include? 'survey:show'
  end

  def show_self?
    user_activities.include? 'survey:show_self'
  end

  def new?
    create?
  end

  def new_self?
    create_self?
  end

  def create?
    user_activities.include? 'survey:create'
  end

  def create_self?
    user_activities.include? 'survey:create_self'
  end

  def edit?
    update?
  end

  def edit_self?
    update_self?
  end

  def update?
    user_activities.include? 'survey:update'
  end

  def update_self?
    user_activities.include? 'survey:update_self'
  end

  def destroy?
    user_activities.include? 'survey:delete'
  end
 
  def destroy_self?
    user_activities.include? 'survey:delete_self'
  end
 
  def work?
    user_activities.include? 'survey:work'
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end