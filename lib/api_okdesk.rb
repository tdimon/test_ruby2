class TypeRequest
  Get = 1
  Post = 2
end

class ApiOkdesk
  require 'net/http'
  require 'api_setting'

  def initialize
    super
    @recordSet = ApiSetting.first
  end

  private def getAccount
    return @recordSet.account
  end

  private def getToken
    return @recordSet.token
  end

  private def sendRequest(uriStr = '', params = {}, typeRequest = TypeRequest::Get)
    account = getAccount
    token = getToken
    params[:api_token] = token

    uri = URI.parse("https://#{account}.testokdesk.ru/api/v1/#{uriStr}")

    response = ''

    case typeRequest
    when TypeRequest::Get
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get(uri)
    when TypeRequest::Post
      response = Net::HTTP.post_form(uri, params)
      return uri
    end

    return response
  end

  def getListCompanies
    response = sendRequest('companies/list')
    return JSON.parse(response)
  end

  def createCompanies(arrNamesCompanies)
    listCompanies = getListCompanies
    result = listCompanies.map { |el| el['name']}
    newNames = arrNamesCompanies - result

    params = {}

    newNames.each { |nameCompany|
      params[:name] = nameCompany
      sendRequest('companies', params, TypeRequest::Post)
    }
  end
end