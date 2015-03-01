require 'spec_helper'

describe 'ROS Transaction in PoS block with multiple addresses' do
  let(:tx) do
    txid = '3cac1620b6f76ef685a7d9a6e4f59b51409fcf151536d23686beb0d5371c8a26'
    client = connect_to_blockexplorer
    client.transaction(txid).decode
  end

  context 'transaction blockhash' do
    block_hash = '18e8ab15a7e2a696a1213b6a49cde58b1229f1b9dea4cf4da86389616a3177c5'
    it { expect(tx['blockhash']).to eq(block_hash) }
  end

  context 'transaction type' do
    it { expect(tx['type']).to eq('stake') }
  end

  context 'transaction inputs' do
    subject { tx['inputs'] }
    expected = [
      { 'value' => 19998.50004099,
        'address' => 'RHSqmuk2Ded5NgqVDWst4DNpQM8vUTVcAM' },
      { 'value' => 1.01703986, 'address' => 'RB3DS6JyTW2D6vJW2dSqhMM6Gfz2ZjrdHZ' },
      { 'value' => 0.01041759, 'address' => 'RFyhzYqUh3EcXrVjjuorTEJwbKHuKGk4Ka' },
      { 'value' => 0.37498275, 'address' => 'RQiMKi2ksHbrg2iy989q8YzM3sWD1nKNzq' },
      { 'value' => 0.01060726, 'address' => 'RUwgfPC4nCYb5a5CGRwKKnUeneGtzM1McE' }
    ]

    it { expect(subject).to eq(expected) }
  end

  context 'transaction outputs' do
    subject { tx['outputs'] }
    expected = [
      { 'value' => 0.01308845, 'address' => 'RUeRowdQs4Kkac67ULeN4ay2A1vyFiXnVP' },
      { 'value' => 19999.8,    'address' => 'RXEVtGEcqbtqzcPHux57p3Zc989SV9kL7A' }
    ]

    it { expect(subject).to eq(expected) }
  end
end
