class CompaniesController < ApplicationController
  def index
    @listCompanies = Company.getList
    if (@listCompanies.include? 'errors')
      redirect_to edit_api_setting_path(ApiSetting.first), :danger => "Невереные настройки api"
    end
  end

  def load_xls
    file = params['file']
    result = Company.createCompaniesFromFile?(file.path)
    if result
      render plain: 'OK'
    end
  end
end
