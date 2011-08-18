require 'helper'

describe WorldBank::IncomeLevel do
  context 'find' do
    it 'returns a WorldBank::IncomeLevel' do
      stub_get('incomeLevels/lmc?format=json').
        to_return(:status => 200, :body => fixture('income_level_lmc.json'))
      @working_class = WorldBank::IncomeLevel.find('lmc').fetch
      a_get('incomeLevels/lmc?format=json').should have_been_made
      @working_class.should be_a WorldBank::IncomeLevel
    end
    context 'returned IncomeLevel has' do
      before do
        stub_get('incomeLevels/lmc?format=json').
          to_return(:status => 200, :body => fixture('income_level_lmc.json'))
        @working_class = WorldBank::IncomeLevel.find('lmc').fetch
      end
      it 'an id' do
        @working_class.id.should eql 'LMC'
      end
      it 'a name' do
        @working_class.name.should eql 'Lower middle income'
      end
    end
  end
end
