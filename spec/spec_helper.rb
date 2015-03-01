$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'webmock/rspec'
require 'bce-client'

def connect_to_blockexplorer
  BceClient::Client.new \
    username: 'rpcuser',
    password: 'rpcpass',
    host: '127.0.0.1', port: '19999'
end

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:post, /rpcuser:rpcpass@127.0.0.1:19999/)
      .to_return(lambda do |req|
        fixture_name = JSON.parse(req.body).values.flatten.join '.'
        file_path = File.expand_path "../fixtures/#{fixture_name}", __FILE__
        { body: File.read(file_path) }
      end)
  end
end
