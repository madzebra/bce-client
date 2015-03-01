require 'net/http'
require 'uri'
require 'json'

module BceClient
  class RPC
    def initialize(service_url)
      @uri = URI.parse(service_url)
    end

    def method_missing(name, *args)
      post_body = { 'method' => name, 'params' => args, 'id' => 'jsonrpc' }
      resp = JSON.parse(http_post_request(post_body.to_json))
      raise BceClient::JSONRPCError, resp['error']['message'] if resp['error']
      resp['result']
    end

    def http_post_request(post_body)
      http    = Net::HTTP.new(@uri.host, @uri.port)
      request = Net::HTTP::Post.new(@uri.request_uri)
      request.basic_auth @uri.user, @uri.password
      request.content_type = 'application/json'
      request.body = post_body
      http.start
      response = http.request(request).body
      http.finish
      response
    end
  end
end
