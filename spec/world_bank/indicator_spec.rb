require 'helper'

describe WorldBank::Indicator do
  context 'find' do
    it 'returns a WorldBank::Indicator' do
      stub_get('indicators/AG.AGR.TRAC.NO?format=json').
        to_return(:status => 200, :body => fixture('indicators_tractors.json'))
      tractors = WorldBank::Indicator.find('AG.AGR.TRAC.NO')
      a_get('indicators/AG.AGR.TRAC.NO?format=json').should have_been_made
      tractors.should be_a WorldBank::Indicator
    end
    context 'returned Indicator has' do
      before do
        stub_get('indicators/AG.AGR.TRAC.NO?format=json').
          to_return(:status => 200, :body => fixture('indicators_tractors.json'))
        @tractors = WorldBank::Indicator.find 'AG.AGR.TRAC.NO'
      end
      it 'an id' do
        @tractors.id.should eql 'AG.AGR.TRAC.NO'
      end
      it 'a name' do
        @tractors.name.should eql 'Agricultural machinery, tractors'
      end
      it 'a source' do
        @tractors.source.should be_a WorldBank::Source
      end
      it 'a note' do
        @tractors.note[0..19].should eql 'Agricultural machine'
      end
      it 'an organization' do
        @tractors.organization.should eql 'Food and Agriculture Organization, electronic files and web site.'
      end
      it 'many topics' do
        @tractors.topics[0].should be_a WorldBank::Topic
      end
    end
  end
end
