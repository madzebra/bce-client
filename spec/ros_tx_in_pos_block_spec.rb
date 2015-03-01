require 'spec_helper'

describe 'ROS Transaction in PoS block' do
  let(:tx) do
    txid = 'd31861b0c66ba35344aad04210cc70171a0dc6a624ff745f82451bb9a50cd0cd'
    client = connect_to_blockexplorer
    client.transaction(txid).decode
  end

  context 'transaction blockhash' do
    block_hash = '0bd02c6289f8dd7c73a322f054b02073d340649fcb98435705f54ce8ab4453ae'
    it { expect(tx['blockhash']).to eq(block_hash) }
  end

  context 'transaction type' do
    it { expect(tx['type']).to eq('stake') }
  end

  context 'transaction inputs' do
    subject { tx['inputs'].first }

    it { expect(subject['address']).to eq('RUP4hS4TE2LxHmyvgmZUAhAcAMHdhBQMmo') }
    it { expect(subject['value']).to eq(800.26791801) }
  end

  context 'transaction outputs' do
    subject { tx['outputs'].first }

    it { expect(subject['address']).to eq('RUP4hS4TE2LxHmyvgmZUAhAcAMHdhBQMmo') }
    it { expect(subject['value']).to eq(801.7469957) }
  end
end
