class Company < ApplicationRecord
  require 'api_okdesk'
  require 'lib_xls'

  def self.getList
    api = ApiOkdesk.new
    answer = api.getListCompanies
    return answer
  end

  def self.createCompaniesFromFile?(nameFile)
    begin
      libObjXLS = LibXls.new nameFile
      arrNamesCompanies = libObjXLS.getListCompanies
      api = ApiOkdesk.new
      api.createCompanies(arrNamesCompanies)
      return true
    rescue
      return false
    end
  end
end
