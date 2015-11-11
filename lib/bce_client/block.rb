module BceClient
  # Block decoder
  class Block
    def initialize(block_index, rpc)
      @block_index = block_index
      @rpc = rpc
    end

    def decode
      blk = @rpc.getblockbynumber(@block_index, true)
      if blk
        blk['tx'].map! { |tx| TransactionParser.new(tx, @rpc).decode blk }
        blk
      else
        {}
      end
    end
  end
end
