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

    uri = URI.parse("https://#{account}.testokdesk.ru/api/v1/#{uriStr}")
    params[:api_token] = token

    response = ''

    case typeRequest
    when TypeRequest::Get
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get(uri)
    when TypeRequest::Post
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = params.to_json

      response = http.request(request)
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

    newNames.each { |nameCompany|
      param = {company: {name: nameCompany}}
      sendRequest('companies', param, TypeRequest::Post)
    }
  end
end