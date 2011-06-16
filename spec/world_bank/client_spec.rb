require 'helper'

describe WorldBank::Client do

  before do
    @client = WorldBank::Client.new
  end
  
  context 'sources' do
    it 'returns all of the sources for the world bank' do
      
    end
  end

  context 'get' do
    it 'returns the response from the specified path' do
      stub_get('sources').
        to_return(:status => 200, :body => 'good job')
      @client.send(:get, 'sources').should eql 'good job'
    end
  end

  context 'connection' do 
    it 'returns an instance of Faraday' do
      @client.send(:connection).should be_a Faraday::Connection
    end
  end

end
