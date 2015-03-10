require 'spec_helper'

describe 'ROS Transactions' do
  let(:client) { connect_to_blockexplorer }

  context 'valid txid' do
    txid = '80182d6ffae100f0b6ac3b981226f809868dd1b942cac8ca07a8f887f8d5f038'
    it { expect(client.transaction(txid).valid?).to be true }
  end

  context 'invalid txid' do
    txid = '0000012222507ab42de6cf10407567d389a6578357eaafab23c5c95c9e56ea56'
    it { expect(client.transaction(txid).valid?).to be false }
  end

  context 'dumb txid' do
    txid = 'BOO'
    it { expect(client.transaction(txid).valid?).to be false }
  end

  context 'dumb txid value' do
    txid = 'BOO'
    it { expect(client.transaction(txid).decode).to be_empty }
  end
end
