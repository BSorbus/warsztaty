class WorksController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :datatables_index, :datatables_index_trackable, :datatables_index_user]


  def index
    #@works = PublicWork::Work.order(created_at: :desc).all
    #@works = Work.order(created_at: :desc).all
    authorize :work, :index?
  end

  def datatables_index
    respond_to do |format|
      format.json{ render json: WorkDatatable.new(params) }
    end
  end

  def datatables_index_trackable
    respond_to do |format|
      format.json{ render json: WorkDatatable.new(params, { trackable_id: params[:trackable_id], trackable_type: params[:trackable_type] }) }
    end
  end

  def datatables_index_user
    respond_to do |format|
      format.json{ render json: WorkDatatable.new(params, { only_for_current_user_id: params[:user_id] }) }
    end
  end

end
