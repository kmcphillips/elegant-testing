class HashService

  def md5(string)
    # Randomly pick an implementation.
    if rand >= 0.5
      md5_httparty string
    else
      md5_faraday string
    end
  end

  def md5_httparty(string)
    response = HTTParty.get("http://md5.jsontest.com/.json?text=#{ string }")
    response["md5"]
  end

  def md5_faraday(string)
    connection = Faraday.new(url: 'http://md5.jsontest.com') do |faraday|
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
    response = connection.get '/.json', text: string
    response.body["md5"]
  end

end
