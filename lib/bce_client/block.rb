module BceClient
  class Block
    def initialize(block_hash, rpc)
      @rpc = rpc
      @block_hash = nil
      unless block_hash.nil?
        @block_hash = block_hash.to_i if valid_block_num? block_hash.to_s
        @block_hash = block_hash      if valid_block_hash? block_hash.to_s
      end
    end

    def count
      @rpc.getblockcount.to_i
    rescue BceClient::JSONRPCError
      0
    end

    def decode
      getblock
    end

    def decode_with_tx
      blk = getblock
      return blk if blk.empty? # otherwise decode all transactions
      blk['tx'] = blk['tx'].map { |tx| Transaction.new(tx, @rpc).decode blk }
      blk
    end

    def valid?
      !getblock.empty?
    end

    private

    def getblock
      return [] if @block_hash.nil?
      if @block_hash.is_a? Integer
        @rpc.getblockbynumber @block_hash
      else
        @rpc.getblock @block_hash
      end
    rescue BceClient::JSONRPCError
      []
    end

    def valid_block_hash?(hash)
      (hash.length == 64) && (hash =~ /[^\w]+/).nil?
    end

    def valid_block_num?(num)
      (num.length < 8) && (num =~ /[^0-9]+/).nil?
    end
  end
end
