require 'helper'

describe WorldBank::Client do

  before do
    @client = WorldBank::Client.new
  end
  
  context 'topics' do
    it 'returns all of the topics for the world bank' do
      stub_get('topics?format=json').
        to_return(:status => 200, :body => fixture('topics.json'))
      test = @client.topics
      a_get('topics?format=json').should have_been_made
      test[0][:total].should eql 18
    end    
  end

  context 'indicators' do
    it 'returns all of the indicators for the world bank' do
      stub_get('indicators?format=json').
        to_return(:status => 200, :body => fixture('indicators.json'))
      test = @client.indicators
      a_get('indicators?format=json').should have_been_made
      test[0][:pages].should eql 82
    end
  end

  context 'countries' do
    it 'returns all of the countries for the world bank' do
      stub_get('countries?format=json').
        to_return(:status => 200, :body => fixture('countries.json'))
      test = @client.countries
      a_get('countries?format=json').should have_been_made
      test[0][:pages].should eql 5
    end
  end

  context 'lending_types' do
    it 'returns all of the lending types for the world bank' do
      stub_get('lendingTypes?format=json').
        to_return(:status => 200, :body => fixture('lending_types.json'))
      test = @client.lending_types
      a_get('lendingTypes?format=json').should have_been_made
      test[0][:total].should eql '4'
    end
  end
  
  context 'income_levels' do
    it 'returns all of the income levels for the world bank' do
      stub_get('incomeLevels?format=json').
        to_return(:status => 200, :body => fixture('income_levels.json'))
      test = @client.income_levels
      a_get('incomeLevels?format=json').should have_been_made
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
