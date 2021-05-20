class CompaniesController < ApplicationController
  def index
    @listCompanies = Company.getList
  end

  def load_xls
    file = params['file']
    Company.createCompaniesFromFile?(file.path)
  end
end
