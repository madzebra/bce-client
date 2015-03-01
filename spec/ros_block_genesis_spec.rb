require 'spec_helper'

describe 'ROS Genesis Block' do
  let(:block) do
    block_hash = '0000012222507ab42de6cf10407567d389a6578357eaafab23c5c95c9e56ea55'
    client = connect_to_blockexplorer
    client.block(block_hash).decode
  end

  context 'height of genesis block' do
    it { expect(block['height']).to eq(1) }
  end

  context 'mint of genesis block' do
    it { expect(block['mint']).to eq(0.00000000) }
  end

  context 'difficulty of genesis block' do
    it { expect(block['difficulty']).to eq(0.00024414) }
  end

  context 'prevhash of genesis block' do
    hash = '000006b1b5cb421be0743a288dbd8c1f0b3fbe906a909f39e854460b3cd5c132'
    it { expect(block['previousblockhash']).to eq(hash) }
  end

  context 'nexthash of genesis block' do
    hash = '00000f471bccb9434b7b588fb978a4062dfd0ea9d3b27b49826e205e51678284'
    it { expect(block['nextblockhash']).to eq(hash) }
  end

  context 'flags of genesis block' do
    it { expect(block['flags']).to eq('proof-of-work') }
  end

  context 'transaction of genesis block' do
    txid = 'ebf540a431c68c7a173ac8da881eb35fe3004130d54f05c43265e813c22b070a'
    it { expect(block['tx'].first).to eq(txid) }
  end
end
