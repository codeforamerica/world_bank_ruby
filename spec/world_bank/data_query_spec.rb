require 'helper'

describe WorldBank::DataQuery do
  context 'lending types' do
    it 'accepts a single LendingType as param' do
      stub_get('lendingTypes/IDB/indicators/all?format=json')
      lending_type = WorldBank::LendingType.new({"id" => "IDB","value" => "Blend"})
      WorldBank::Data.raw.lending_type(lending_type).fetch
      a_get('lendingTypes/IDB/indicators/all?format=json').should have_been_made
    end
  end
  context 'income levels' do
    it 'accepts a single IncomeLevels as param' do
      stub_get('incomeLevels/LMC/indicators/all?format=json')
      WorldBank::Data.raw.income_level('LMC').fetch
      a_get('incomeLevels/LMC/indicators/all?format=json').should have_been_made
    end
  end
  context 'sources' do
    it 'accepts a single Source as param' do
      stub_get('sources/1/indicators/all?format=json')
      WorldBank::Data.raw.source(1).fetch
      a_get('sources/1/indicators/all?format=json').should have_been_made
    end
  end
  context 'country' do
    it 'adds countries to the params if given ISO-2 code' do
      stub_get('countries/br/indicators/AB.LND.ARBL.ZS?format=json')
      WorldBank::Data.find('AB.LND.ARBL.ZS').country('br').raw.fetch
      a_get('countries/br/indicators/AB.LND.ARBL.ZS?format=json').should have_been_made
    end
    it 'adds countries to the params if given human name' do
      stub_get('countries/BR/indicators/AB.LND.ARBL.ZS?format=json')
      WorldBank::Data.find('AB.LND.ARBL.ZS').country('brazil').raw.fetch
      a_get('countries/BR/indicators/AB.LND.ARBL.ZS?format=json').should have_been_made
    end
  end
end
