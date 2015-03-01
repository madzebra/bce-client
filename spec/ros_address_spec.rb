require 'spec_helper'

describe 'ROS Address' do
  let(:client) { connect_to_blockexplorer }

  context 'valid address' do
    address = 'RESAZvqFJFSzKZhuWnUztjoikCnFMazQSV'
    it { expect(client.address(address).valid?).to be true }
  end

  context 'invalid address' do
    address = 'RESA1vqFJFSzKZhuWnUztjoikCnFMazQSV'
    it { expect(client.address(address).valid?).to be false }
  end

  context 'messy address' do
    address = 'foobar'
    it { expect(client.address(address).valid?).to be false }
  end
end
