require 'helper'

describe WorldBank::Country do
  context 'client' do
    it 'returns WorldBank::Client' do
      client = WorldBank::Country.client
      client.should be_a WorldBank::Client
    end
  end
  context 'find' do
    it 'returns the correct Country' do
      stub_get('countries/in?format=json').
        to_return(:status => 200, :body => fixture('countries_india.json'))
      india = WorldBank::Country.find('in')
      a_get('countries/in?format=json').should have_been_made
      india.should be_a WorldBank::Country
    end
    context 'returned Country has' do
      before do
        stub_get('countries/in?format=json').
          to_return(:status => 200, :body => fixture('countries_india.json'))
        @india = WorldBank::Country.find('in')
      end
      it 'a three letter code' do
        @india.iso3_code.should eql 'IND'
      end
      it 'a two letter code' do
        @india.iso2_code.should eql 'IN'
      end
      it 'a name' do
        @india.name.should eql 'India'
      end
      it 'an IncomeLevel' do
        @india.income_level.should be_a WorldBank::IncomeLevel
      end
      it 'a LendingType' do
        @india.lending_type.should be_a WorldBank::LendingType
      end
      it 'a capital' do
        @india.capital.should eql 'New Delhi'
      end
      it 'a region' do
        @india.region.should be_a WorldBank::Region
      end
    end
  end
end
