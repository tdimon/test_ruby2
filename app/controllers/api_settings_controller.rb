class ApiSettingsController < ApplicationController
  def show
    @apiSet = ApiSetting.first
  end

  def edit
    @apiSet = ApiSetting.find(params[:id])
  end

  def update
    @apiSet = ApiSetting.find(params[:id])
    if (@apiSet.update(post_params))
      redirect_to home_path
    else
      render 'edit'
    end
  end

  private def post_params
    params.require(:api_setting).permit(:account, :token)
  end
end
