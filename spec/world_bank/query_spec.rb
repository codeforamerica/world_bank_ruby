require 'helper'

describe WorldBank::Query do
  context 'dates' do
    it 'should return self' do
      WorldBank::Source.all.dates('something').should be_a_kind_of WorldBank::Query
    end
    it 'adds a date string to the params hash' do
      stub_get('sources/all?date=2000:2010&format=json')
      WorldBank::Source.all.raw.dates('2000:2010').fetch
      a_get('sources/all?date=2000:2010&format=json').should have_been_made
    end
    it 'adds a range of date objects to the params hash' do
      stub_get('sources/all?date=1982M03:2010M09&format=json')
      birthday = Date.new(1982, 3, 7)
      q3 = Date.new(2010, 9, 30)
      WorldBank::Source.all.raw.dates(birthday...q3).fetch
      a_get('sources/all?date=1982M03:2010M09&format=json').should have_been_made
    end
  end
  context 'format' do
    it 'adds a format string to the params' do
      stub_get('sources/all?format=xml')
      WorldBank::Source.all.raw.format(:xml).fetch
      a_get('sources/all?format=xml').should have_been_made
    end
  end
  context 'most_recent_values' do
    it 'adds a MRV to the params' do
      stub_get('sources/all?MRV=5&format=json')
      WorldBank::Source.all.raw.most_recent_values(5).fetch
      a_get('sources/all?MRV=5&format=json').should have_been_made end
  end
  context 'per page' do
    it 'adds a perPage string to the params' do
      stub_get('sources/all?perPage=50&format=json')
      WorldBank::Source.all.raw.per_page(50).fetch
      a_get('sources/all?perPage=50&format=json').should have_been_made
    end
  end
  context 'page' do
    it 'adds a page param when passed a value' do
      stub_get('sources/all?page=3&format=json')
      WorldBank::Source.all.raw.page(3).fetch
      a_get('sources/all?page=3&format=json').should have_been_made
    end
  end
  context 'next' do
    it 'increments the page count' do
      stub_get('sources/all?page=3&format=json')
      query = WorldBank::Source.all.raw.page(2)
      query.next.fetch
      a_get('sources/all?page=3&format=json').should have_been_made
    end
  end
  context 'cycle' do
    it 'cycles through all of the pages of results' do
      3.times do |i|
        stub_get("sources/all?page=#{i+1}&format=json").
          to_return(:status => 200, :body => ["#{i+1}"])
      end
      query = WorldBank::Source.all.raw.page(1)
      query.instance_variable_set(:@pages, 3)
      query.cycle.should == ["2", "3"]
    end
  end
  context 'language' do
    it 'adds language param to the front of the query path' do
      stub_get('es/sources/all?format=json')
      WorldBank::Source.all.raw.language(:spanish).fetch
      a_get('es/sources/all?format=json').should have_been_made
    end
  end
end
