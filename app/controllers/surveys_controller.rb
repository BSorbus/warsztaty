class SurveysController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :datatables_index_user]
  before_action :set_survey, only: [:show, :edit, :update, :destroy]


  def export
  end

  # GET /surveys
  # GET /surveys.json
  def index
    authorize :survey, :index?
    respond_to do |format|
      format.html
      format.json { render json: SurveyDatatable.new(params) }
    end
  end

  def datatables_index_user
    respond_to do |format|
      format.json{ render json: UserSurveysDatatable.new(params, { only_for_current_user_id: params[:user_id] }) }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    authorize @survey, :show?
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
    authorize @survey, :new?
  end

  # GET /surveys/1/edit
  def edit
    authorize @survey, :edit?
  end

  # POST /surveys
  # POST /surveys.json
  def create
    # @survey = Survey.new(name: params[:survey][:name], note: params[:survey][:note], special: params[:survey][:special],activities: params[:survey][:activities].split)
    @survey = Survey.new(survey_params)
    authorize @survey, :create?
    respond_to do |format|
      if @survey.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @survey.fullname)
        @survey.log_work('create', current_user.id)
        format.html { redirect_to @survey }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    authorize @survey, :update?
    respond_to do |format|
      # if @survey.update(name: params[:survey][:name], note: params[:survey][:note], special: params[:survey][:special],activities: params[:survey][:activities].split)
      if @survey.update(survey_params)
        flash[:success] = t('activerecord.successfull.messages.updated', data: @survey.fullname)
        @survey.log_work('update', current_user.id)
        format.html { redirect_to @survey }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    # @survey.destroy
    # respond_to do |format|
    #   flash[:success] = "Survey destroyed!"
    #   format.html { redirect_to surveys_url }
    #   format.json { head :no_content }
    # end
    authorize @survey, :destroy?
    if @survey.destroy
      flash[:success] = t('activerecord.successfull.messages.destroyed', data: @survey.fullname)
      redirect_to surveys_url
    else 
      flash.now[:error] = t('activerecord.errors.messages.destroyed', data: @survey.fullname)
      #redirect_to :back
      render :show
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit( :answer_1_place_1, :answer_1_place_2, :answer_1_place_3,
                                      :answer_2_place_1, :answer_2_place_2, :answer_2_place_3,
                                      :answer_3_place_1, :answer_3_place_2, :answer_3_place_3,
                                      :answer_4_place_1, :answer_4_place_2, :answer_4_place_3,
                                      :answer_5_place_1, :answer_5_place_2, :answer_5_place_3, :note, :user_id)
    end
end
