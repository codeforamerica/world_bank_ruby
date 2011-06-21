require 'helper'

describe WorldBank::LendingType do
  context 'client' do
    it 'should return a Client' do
      client = WorldBank::LendingType.client
      client.should be_a WorldBank::Client
    end
  end
  context 'find' do
    it 'returns a LendingType' do
      stub_get('lendingTypes/idb?format=json').
        to_return(:status => 200, :body => fixture('lending_type_idb.json'))
      @blend = WorldBank::LendingType.find('idb')
      a_get('lendingTypes/idb?format=json').should have_been_made
      @blend.should be_a WorldBank::LendingType
    end
    context 'returned LendingType has' do
      before do
        stub_get('lendingTypes/idb?format=json').
          to_return(:status => 200, :body => fixture('lending_type_idb.json'))
        @blend = WorldBank::LendingType.find('idb')
      end
      it 'an id' do
        @blend.id.should eql 'IDB'
      end
      it 'a name' do
        @blend.name.should eql 'Blend'
      end
    end
  end
end
