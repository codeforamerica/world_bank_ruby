require 'helper'

describe WorldBank::Source do
  context 'find' do
    it 'returns a new Source object' do
      stub_get('sources/21?format=json').
        to_return(:status => 200, :body => fixture('source_21.json'))
      @gem = WorldBank::Source.find(21).fetch
      a_get('sources/21?format=json').should have_been_made
      @gem.should be_a WorldBank::Source
    end
    context 'returned Source has' do
      before do
        stub_get('sources/21?format=json').
          to_return(:status => 200, :body => fixture('source_21.json'))
        @gem = WorldBank::Source.find(21).fetch
      end
      it 'an id' do
        @gem.id.should eql '21'
      end
      it 'a name' do
        @gem.name.should eql 'Global Economic Monitor (GEM) Commodities'
      end
      it 'a description' do
        @gem.description.should eql ''
      end
      it 'a url' do
        @gem.url.should eql ''
      end
    end
  end
end
