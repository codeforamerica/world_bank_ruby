require 'helper'

describe WorldBank::Query do
  before do
    @india = {"id" => "IND",
              "iso2Code" => "IN",
              "name" => "India",
              "region" => {
                "id" => "SAS",
                "value" => "South Asia"},
              "adminregion" => {
                "id" => "SAS",
                "value" => "South Asia"},
              "incomeLevel" => {
                "id" => "LMC",
                "value" => "Lower middle income"},
              "lendingType" => {
                "id" => "IDB",
                "value" => "Blend"},
              "capitalCity" => "New Delhi",
              "longitude" => "77.225",
              "latitude" => "28.6353"}
    @country = WorldBank::Country.new(@india)
    @query = WorldBank::Query::Base.new(@country)
    @client = @query.instance_variable_get :@client
  end
  context 'client' do
    it 'returns WorldBank::Client' do
      @client.should be_a WorldBank::Client
    end
  end
  context 'dates' do
    it 'adds a date string to the params hash' do
      @query.dates('2000:2010')
      @client.query[:params].should eql({:format => 'json', :date => '2000:2010'})
    end
    it 'adds a range of date objects to the params hash' do
      @birthday = Date.new(1982, 3, 7)
      @q3 = Date.new(2010, 9, 30)
      @query.dates(@birthday...@q3)
      @client.query[:params].should eql({:format => 'json', :date => '1982M03:2010M09'})
    end
  end
  context 'format' do
    it 'adds a format string to the params' do
      @query.format('xml')
      @client.query[:params].should eql({:format => 'xml'})
    end
  end
  context 'id' do
    it 'adds an id string to the params' do
      @query.id(9)
      @client.query[:params].should eql({:format => 'json', :id => 9})
    end
  end
  context 'most_recent_values' do
    it 'adds a MRV to the params' do
      @query.most_recent_values(10)
      @client.query[:params].should eql({:format => 'json', :MRV => 10})
    end
  end
  context 'per page' do
    it 'adds a perPage string to the params' do
      @query.per_page(50)
      @client.query[:params].should eql({:format => 'json', :perPage => 50})
    end
  end
  context 'page' do
    it 'adds a page param' do
      @query.page(3)
      @client.query[:params].should eql({:format => 'json', :page => 3})
    end
  end
  context 'language' do
    it 'adds one of (en, es, fr, ar) to the dir array' do
      @query.language('es')
      @client.query[:dirs].should eql(['countries', 'es'])
    end
  end
  context 'lending types' do
    it 'accepts a single LendingType as param' do
      @query = WorldBank::Query::Base::Countries.new(@country)
      @client = @query.instance_variable_get :@client
      @lending_type = WorldBank::LendingType.new({"id" => "IDB","value" => "Blend"})
      @query.lending_types(@lending_type)
      @client.query[:params].should eql({:format => 'json', :lendingTypes => 'IDB'})
    end
    it 'converts an array of LendingTypes to a param' do
      @query = WorldBank::Query::Base::Countries.new(@country)
      @client = @query.instance_variable_get :@client
      @lending_type = WorldBank::LendingType.new({"id" => "IDB","value" => "Blend"})
      @other_type = @lending_type.dup
      @query.lending_types([@other_type, @lending_type])
      @client.query[:params].should eql({:format => 'json', :lendingTypes => 'IDB;IDB'})
    end
  end
  context 'income levels' do
    it 'accepts a single IncomeLevels as param' do
      @query = WorldBank::Query::Base::Countries.new(@country)
      @client = @query.instance_variable_get :@client
      @income_level = WorldBank::IncomeLevel.new({"id" => "LMC","value" => "Lower middle income"})
      @query.income_levels(@income_level)
      @client.query[:params].should eql({:format => 'json', :incomeLevels => 'LMC'})
    end
    it 'converts an array of IncomeLevels to a param' do
      @query = WorldBank::Query::Base::Countries.new(@country)
      @client = @query.instance_variable_get :@client
      @income_level = WorldBank::IncomeLevel.new({"id" => "LMC","value" => "Lower middle income"})
      @other_type = @income_level.dup
      @query.income_levels([@other_type, @income_level])
      @client.query[:params].should eql({:format => 'json', :incomeLevels => 'LMC;LMC'})
    end
  end
end
