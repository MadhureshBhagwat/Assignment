class PersonalDataController < ApplicationController
  before_action :get_personal_data, only: %i[ show update destroy ]
  before_action :ensure_frame_response, only: :new

  def index
    @personal_data = PersonalData.includes(:employments).all
  end

  def new
    @personal_data = PersonalData.new
  end

  def create
    @personal_data = PersonalData.new(personal_data_params)
    respond_to do |format|
      if @personal_data.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove('personal-data-form') +
          turbo_stream.update(
            'employment-modal',
            partial: 'employments/employment_modal',
            locals: { personal_data_id: @personal_data.id }
          )
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @personal_data.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @personal_data.destroy
      redirect_to root_path
    end
  end

  private
    def get_personal_data
      @personal_data = PersonalData.find(params[:id])
    end

    def ensure_frame_response
      return unless Rails.env.development?
      redirect_to root_path unless turbo_frame_request?
    end

    def personal_data_params
      params.require(:personal_data).permit(:first_name, :last_name, :nickname, :email, :phone_number)
    end
end
