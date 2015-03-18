module BceClient
  class Transaction
    def initialize(txid, rpc)
      @txid = txid
      @rpc = rpc
    end

    def decode(tx_block = nil)
      tx = gettransaction
      return tx if tx.empty?
      blk = tx_block.nil? ? @rpc.getblock(tx['blockhash']) : tx_block

      parser = TransactionParser.new tx, @rpc
      parser.decode blk
    end

    def valid?
      !gettransaction.empty?
    end

    private

    def gettransaction
      return [] unless valid_hash?
      @rpc.gettransaction @txid
    rescue BceClient::JSONRPCError
      []
    end

    def valid_hash?
      (@txid.length == 64) && (@txid =~ /[^\w]+/).nil?
    end
  end
end
