require 'spec_helper'

describe 'ROS Ordinary Block' do
  let(:block) do
    block_hash = '18e8ab15a7e2a696a1213b6a49cde58b1229f1b9dea4cf4da86389616a3177c5'
    client = connect_to_blockexplorer
    client.block(block_hash).decode
  end

  context 'height of block' do
    it { expect(block['height']).to eq(86_229) }
  end

  context 'mint of block' do
    it { expect(block['mint']).to eq(1.41697916) }
  end

  context 'difficulty of block' do
    it { expect(block['difficulty']).to eq(0.00142105) }
  end

  context 'prevhash of block' do
    hash = '761395b3192e48794727c914d8e7ac3ab9910dd38bf915f2a3e9e4d595db4aa7'
    it { expect(block['previousblockhash']).to eq(hash) }
  end

  context 'nexthash of block' do
    hash = '4f9012cf9344de365cb910883e89387d1fd648cf11440d90c30fe56ddc2786ce'
    it { expect(block['nextblockhash']).to eq(hash) }
  end

  context 'flags of block' do
    it { expect(block['flags']).to eq('proof-of-stake') }
  end

  context 'transactions of block' do
    tx = %w(
      ddc76b2b4ef66053a02cdfcea19ba7d85d0b5104afbf4a80b0e4a79741278146
      581a2f11d48e1b83f198744a5f0527fb112ad9bdb6f9153660170378cb7dabca
      3cac1620b6f76ef685a7d9a6e4f59b51409fcf151536d23686beb0d5371c8a26
    )
    it { expect(block['tx']).to eq(tx) }
  end
end
