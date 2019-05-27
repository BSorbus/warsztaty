class ExpositionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index]
  before_action :set_exposition, only: [:show, :edit, :update, :destroy]

  # GET /expositions
  # GET /expositions.json
  def index
    @expositions = Exposition.all
  end

  # GET /expositions/1
  # GET /expositions/1.json
  def show
  end

  # GET /expositions/new
  def new
    @exposition = Exposition.new
  end

  # GET /expositions/1/edit
  def edit
  end

  # POST /expositions
  # POST /expositions.json
  def create
    @exposition = Exposition.new(exposition_params)
    @exposition.user = current_user
    authorize @exposition, :create?
    respond_to do |format|
      if @exposition.save
        flash[:success] = t('activerecord.successfull.messages.created', data: @exposition.name)
        @exposition.log_work('create', current_user.id)
        format.html { redirect_to expositions_url }
        format.json { render :show, status: :created, location: @exposition }
      else
        format.html { redirect_to expositions_url }
        format.json { render json: @exposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expositions/1
  # PATCH/PUT /expositions/1.json
  def update
    respond_to do |format|
      if @exposition.update(exposition_params)
        format.html { redirect_to @exposition, notice: 'Exposition was successfully updated.' }
        format.json { render :show, status: :ok, location: @exposition }
      else
        format.html { render :edit }
        format.json { render json: @exposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expositions/1
  # DELETE /expositions/1.json
  def destroy
    @exposition.destroy
    respond_to do |format|
      format.html { redirect_to expositions_url, notice: 'Exposition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exposition
      @exposition = Exposition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exposition_params
      params.require(:exposition).permit(:name, :user_id, :photo)
    end
end
