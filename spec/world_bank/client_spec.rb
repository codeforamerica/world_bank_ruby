require 'helper'

describe WorldBank::Client do

  before do
    @client = WorldBank::Client.new
  end
  
  context 'topics' do
    it 'returns all of the topics for the world bank' do
      stub_get('topics').
        to_return(:status => 200, :body => fixture('topics.json'))
      test = @client.topics
      a_get('topics').should have_been_made
      test[0][:total].should eql 18
    end    
  end

  context 'indicators' do
    it 'returns all of the indicators for the world bank' do
      stub_get('indicators').
        to_return(:status => 200, :body => fixture('indicators.json'))
      test = @client.indicators
      a_get('indicators').should have_been_made
      test[0][:pages].should eql 82
    end
  end

  context 'countries' do
    it 'returns all of the countries for the world bank' do
      stub_get('countries').
        to_return(:status => 200, :body => fixture('countries.json'))
      test = @client.countries
      a_get('countries').should have_been_made
      test[0][:pages].should eql 5
    end
  end

  context 'lending_types' do
    it 'returns all of the lending types for the world bank' do
      stub_get('lendingTypes').
        to_return(:status => 200, :body => fixture('lending_types.json'))
      test = @client.lending_types
      a_get('lendingTypes').should have_been_made
      test[0][:total].should eql '4'
    end
  end
  
  context 'income_levels' do
    it 'returns all of the income levels for the world bank' do
      stub_get('incomeLevels').
        to_return(:status => 200, :body => fixture('income_levels.json'))
      test = @client.income_levels
      a_get('incomeLevels').should have_been_made
      test[0][:total].should eql '9'
    end
  end
  
  context 'sources' do
    it 'returns all of the sources for the world bank' do
      stub_get('sources?format=json').
        to_return(:status => 200, :body => fixture('sources.json'))
      test = @client.sources
      a_get('sources?format=json').should have_been_made
      test[0][:total].should eql '14'
    end
  end

  context 'get' do
    it 'returns the response from the specified path' do
      stub_get('sources?format=json').
        to_return(:status => 200, :body => fixture('sources.json'))
      test = @client.sources
      a_get('sources?format=json').should have_been_made
      test[0][:total].should eql '14'
    end
  end

  context 'connection' do 
    it 'returns an instance of Faraday' do
      @client.send(:connection).should be_a Faraday::Connection
    end
  end

end
