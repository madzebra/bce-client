require 'spec_helper'

describe 'ROS Transaction of PoW block' do
  let(:tx) do
    txid = '80182d6ffae100f0b6ac3b981226f809868dd1b942cac8ca07a8f887f8d5f038'
    client = connect_to_blockexplorer
    client.transaction(txid).decode
  end

  context 'transaction blockhash' do
    block_hash = '00000000007fd09a8977c9b7c8a95b4ed651f1969313f64abb57aef785581b51'
    it { expect(tx['blockhash']).to eq(block_hash) }
  end

  context 'transaction type' do
    it { expect(tx['type']).to eq('work') }
  end

  context 'transaction inputs' do
    subject { tx['inputs'].first }

    it { expect(subject['address']).to eq('PoW Generation') }
    it { expect(subject['value']).to eq(2000.0) }
  end

  context 'transaction outputs' do
    subject { tx['outputs'].first }

    it { expect(subject['address']).to eq('RDS6Cm5yYZeboPsUpqDYYmimdDNfDS5SqA') }
    it { expect(subject['value']).to eq(2000.0) }
  end
end
