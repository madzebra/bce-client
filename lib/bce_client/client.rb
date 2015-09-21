module BceClient
  class Client
    def initialize(options = {})
      rpc_user = options[:username] || 'user'
      rpc_pass = options[:password] || 'pass'
      rpc_host = options[:host] || '127.0.0.1'
      rpc_port = options[:port] || '8080'
      service_url = "http://#{rpc_user}:#{rpc_pass}@#{rpc_host}:#{rpc_port}"
      @rpc = BceClient::RPC.new service_url
    end

    def address(addr)
      Address.new addr, @rpc
    end

    def block(block_hash = nil)
      Block.new block_hash, @rpc
    end

    def transaction(txid)
      Transaction.new txid, @rpc
    end

    def money_supply
      money_supply_info
    end

    def network_info
      @rpc.getinfo || {}
    end

    def network_peer_info
      @rpc.getpeerinfo || []
    end

    private

    def money_supply_info
      info = @rpc.getinfo
      info.nil? ? 10**8.to_f : info['moneysupply'].to_f
    end
  end
end
