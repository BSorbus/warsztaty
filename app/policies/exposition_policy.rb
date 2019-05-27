class ExpositionPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user_activities.include? 'exposition:index'
  end

  def show?
    user_activities.include? 'exposition:show'
  end

  def new?
    create?
  end

  def create?
    user_activities.include? 'exposition:create'
  end

  def edit?
    update?
  end

  def update?
    user_activities.include? 'exposition:update'
  end

  def destroy?
    user_activities.include? 'exposition:delete'
  end
 
  def work?
    user_activities.include? 'exposition:work'
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end