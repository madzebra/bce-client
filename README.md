# Block Chain Explorer Client

Block Chain Explorer Client for altcoins.

Extracted from BCE project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bce-client', github: 'madzebra/bce-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bce-client

## Usage

```ruby
require 'bce-client'

bce_client = BceClient::Client.new \
  username: 'rpc_user',
  password: 'rpc_pass',
  host: '127.0.0.1',
  port: '19092'

bce_client.block(1).decode_with_tx # => Array with block info + all decoded txs

bce_client.network_info # => hash with getinfo content
bce_client.network_peer_info # => Array of connected peers
```

## Contributing

1. Fork it ( https://github.com/madzebra/bce-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
