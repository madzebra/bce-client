require 'spec_helper'

describe 'ROS Transaction of PoS block' do
  let(:tx) do
    txid = 'a863c908012d5a92de805de71d4cb88432b57a65d881539fbf6236519cc11a8f'
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

    it { expect(subject['address']).to eq('PoS Generation') }
    it { expect(subject['value']).to eq(1.47907769) }
  end

  context 'transaction outputs' do
    subject { tx['outputs'].first }

    it { expect(subject['address']).to eq('stake') }
    it { expect(subject['value']).to eq(1.479077690) }
  end
end
