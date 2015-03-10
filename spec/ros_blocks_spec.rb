require 'spec_helper'

describe 'ROS Blocks' do
  let(:client) { connect_to_blockexplorer }

  context 'block count' do
    it { expect(client.block.count).to be > 10_000 }
  end

  context 'invalid block hash' do
    hash = '0000012222507ab42de6cf10407567d389a6578357eaafab23c5c95c9e56ea56'
    it { expect(client.block(hash).decode).to be_empty }
  end

  context 'invalid block num' do
    it { expect(client.block(1_000_000).decode).to be_empty }
  end

  context 'validity of block by hash' do
    hash = '0000012222507ab42de6cf10407567d389a6578357eaafab23c5c95c9e56ea56'
    it { expect(client.block(hash).valid?).to be false }
  end

  context 'validity of block num' do
    it { expect(client.block(1_000_000).valid?).to be false }
  end

  context 'valid block num' do
    it { expect(client.block(88_000).valid?).to be true }
  end

  context 'invalid block num as a string' do
    it { expect(client.block('1000000').decode).to be_empty }
  end

  context 'validity block num as a string' do
    it { expect(client.block('1000000').valid?).to be false }
  end

  context 'valid block num as a string' do
    it { expect(client.block('88000').valid?).to be true }
  end
end
