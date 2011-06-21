require 'helper'

describe WorldBank::IncomeLevel do
  context 'client' do
    # my god these need to be refactored... but can they be? what about including client within????
    it 'returns a WorldBank::Client' do
      client = WorldBank::IncomeLevel.client
      client.should be_a WorldBank::Client
    end
  end
  context 'find' do
    it 'returns a WorldBank::IncomeLevel' do
      stub_get('incomeLevels/lmc?format=json').
        to_return(:status => 200, :body => fixture('income_level_lmc.json'))
      @working_class = WorldBank::IncomeLevel.find('lmc')
      a_get('incomeLevels/lmc?format=json').should have_been_made
      @working_class.should be_a WorldBank::IncomeLevel
    end
    context 'returned IncomeLevel has' do
      before do
        stub_get('incomeLevels/lmc?format=json').
          to_return(:status => 200, :body => fixture('income_level_lmc.json'))
        @working_class = WorldBank::IncomeLevel.find('lmc')
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
