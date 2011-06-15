require 'helper'

describe WorldBank::Client do

  context 'connection' do
    
    it 'returns an instance of Faraday' do
      client = WorldBank::Client.new
      client.send(:connection).should be_a Faraday::Connection
    end
  end

end
