module BceClient
  class Transaction
    def initialize(txid, rpc)
      @txid = txid
      @rpc = rpc
    end

    def decode(tx_block = nil)
      tx = get_tx
      return nil if tx.nil?
      blk = tx_block.nil? ? @rpc.getblock(tx['blockhash']) : tx_block
      tx['type']    = block_type blk
      tx['inputs']  = parse_inputs tx, blk
      tx['outputs'] = parse_outputs tx, blk
      tx
    end

    def valid?
      tx = get_tx
      return false if tx.nil?
      true
    end

    private

    def get_tx
      return nil unless valid_hash?
      @rpc.gettransaction @txid
    rescue BceClient::JSONRPCError
      nil
    end

    def valid_hash?
      (@txid.length == 64) && (@txid =~ /[^\w]+/).nil?
    end

    def block_type(blk)
      result = 'BUG !!'
      result = 'work' if blk['flags'].include? 'proof-of-work'
      result = 'stake' if blk['flags'].include? 'proof-of-stake'
      result
    end

    def address_type(blk)
      result = 'BUG !!'
      result = 'PoW Generation' if blk['flags'].include? 'proof-of-work'
      result = 'PoS Generation' if blk['flags'].include? 'proof-of-stake'
      result
    end

    def parse_inputs(tx, blk = nil)
      if tx['vin'][0]['coinbase'].nil?
        tx['vin'].map do |txin|
          prevtx = @rpc.gettransaction txin['txid']
          prevout_n = txin['vout'].to_i
          prevout = prevtx['vout'][prevout_n]
          {
            'value' => prevout['value'],
            'address' => prevout['scriptPubKey']['addresses'][0]
          }
        end
      else
        [{ 'address' => address_type(blk), 'value' => blk['mint'] }]
      end
    end

    def parse_outputs(tx, blk = nil)
      if !tx['vin'][0]['coinbase'].nil? && block_type(blk) == 'stake'
        [{ 'address' => 'stake', 'value' => blk['mint'] }]
      else
        tx['vout'].map do |txout|
          {
            'value' => txout['value'],
            'address' => txout['scriptPubKey']['addresses'][0]
          } if txout['scriptPubKey']['type'] != 'nonstandard'
        end.compact
      end
    end
  end
end
