module BceClient
  # Transaction decoder
  class Transaction
    def initialize(txid, rpc)
      @txid = txid
      @rpc = rpc
    end

    def decode(block = nil)
      tx = @rpc.gettransaction(@txid) || {}
      if tx.empty?
        tx
      else
        parser = TransactionParser.new tx, @rpc
        blk = block ? block : Block.new(tx['blockhash'], @rpc).decode
        parser.decode blk
      end
    end
  end
end
