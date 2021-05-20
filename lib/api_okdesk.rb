class ApiOkdesk
  require 'net/http'
  require 'app/models/api_setting'

  def initialize
    super
    @recordSet = ApiSetting.first
  end

  enum {
    Get = 1, Post = 2
  }

  private def getAccount
    return @recordSet.account
  end

  private def getToken
    return @recordSet.token
  end

  private def sendRequest(uriStr = '', params = {}, typeRequest = Get)
    account = getAccount
    token = getToken

    uri = URI.parse('https://#{account}.testokdesk.ru/api/v1/#{uriStr}?api_token=#{token}')

    response = ''

    case typeRequest
    when Get
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get(uri)
    when Post
      response = Net::HTTP.post_form(uri, params)
    end

    return response
  end

  def getListCompanies
    response = sendRequest('companies/list')
    return response
  end

  def createCompanies(listCompanies)

  end
end