module BceClient
  # Transaction parser helper
  class TransactionParser
    DECODE_FILTER = %w(vin vout)

    def initialize(tx, rpc)
      @tx = tx
      @rpc = rpc
    end

    def decode(blk)
      @tx['type']    = block_type blk
      @tx['inputs']  = parse_inputs @tx, blk
      @tx['outputs'] = parse_outputs @tx, blk
      @tx.reject { |k, _| DECODE_FILTER.include? k }
    end

    def block_type(blk)
      flags = blk['flags']
      if flags.include? 'proof-of-work'
        'work'
      elsif flags.include? 'proof-of-stake'
        'stake'
      else
        'nonstandard'
      end
    end

    def address_type(blk)
      flags = blk['flags']
      if flags.include? 'proof-of-work'
        'PoW Generation'
      elsif flags.include? 'proof-of-stake'
        'PoS Generation'
      else
        'nonstandard'
      end
    end

    def parse_inputs(tx, blk = {})
      vin = tx['vin']
      if vin[0]['coinbase']
        [{ 'address' => address_type(blk), 'value' => blk['mint'] }]
      else
        vin.map do |txin|
          prevtx = @rpc.gettransaction txin['txid']
          prevout_n = txin['vout'].to_i
          txout_hash prevtx['vout'][prevout_n]
        end
      end
    end

    def parse_outputs(tx, blk = {})
      if tx['vin'][0]['coinbase'] && block_type(blk) == 'stake'
        [{ 'address' => 'stake', 'value' => blk['mint'] }]
      else
        tx['vout'].map do |txout|
          txout_hash(txout) if txout['scriptPubKey']['type'] != 'nonstandard'
        end.compact
      end
    end

    def txout_hash(txout)
      {
        'value' => txout['value'],
        'address' => txout['scriptPubKey']['addresses'][0]
      }
    end
  end
end
