module BceClient
  # Block decoder
  class Block
    def initialize(block_index, rpc)
      @block_index = block_index
      @rpc = rpc
    end

    def decode
      getblock
    end

    def decode_with_tx
      blk = getblock true
      return blk if blk.empty?
      blk['tx'].map! { |tx| TransactionParser.new(tx, @rpc).decode blk }
      blk
    end

    private

    def getblock(txinfo = false)
      @rpc.getblockbynumber(@block_index, txinfo) || {}
    end
  end
end
