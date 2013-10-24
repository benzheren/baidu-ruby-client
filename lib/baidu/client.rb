require 'baidu/error'
require 'baidu/protocol'

module Baidu
  class Client
    attr_accessor :api_key
    attr_accessor :secret_key

    def initialize(data = Baidu.config)
      @base_host = data[:base_host] || Protocol::BASE_HOST
      @url_scheme = data[:url_scheme] || "https:"
      @api_key = data[:api_key]
      @secret_key = data[:secret_key]

      @session = Patron::Session.new
      @session.timeout = 30
      @session.connect_timeout = 30

      @session.headers["Content-Type"]  = "application/x-www-form-urlencoded"
    end

    def get_sign(method, url, params)
      params_str = params.sort { |a, b| a[0]<=>b[0] }.map { |x| "#{x[0]}=#{x[1]}" }.join
      urlencoded_str = CGI.escape(method.to_s.upcase + url + params_str + @secret_key)
      Digest::MD5.hexdigest(urlencoded_str)
    end

    def gen_body_str(body)
      body.map { |x| "#{x[0]}=#{CGI.escape(x[1].to_s)}" }.join("&")
    end

    def request(service, uri, method = :get, body = nil, query = nil, connect_type = nil)
      options = {}
      headers = {}
      
      base_url = @url_scheme + '//' + service.to_s + @base_host
      @session.base_url = base_url

      if body
        body.merge!({ apikey: @api_key, timestamp: Time.now.to_i })
        body.merge!({ sign: get_sign(method, base_url + uri, body) })
        options[:data] = gen_body_str(body)
      end

      response = @session.request(method, uri, headers, options)

      parsed = JSON.parse(response.body)

      if response.status >= 400
        parsed ||= {}
        raise BaiduProtocolError.new({"error" => "HTTP Status #{response.status} Body #{response.body}"}.merge(parsed))
      end

      return parsed
    end

    def get(service, uri)
      request(service, uri)
    end

    def post(service, uri, body)
      request(service, uri, :post, body)
    end
    
  end

  # Module Methods
  def self.init(config = {})
    @config = {}
    @config.merge!(config)
  end

  def self.config
    @config
  end
end
