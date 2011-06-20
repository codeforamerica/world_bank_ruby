require 'helper'

describe WorldBank::Topic do

  context 'find' do

    it 'returns an instance of Topic' do
      stub_get('topics/6?format=json').
        to_return(:status => 200, :body => fixture('topic_6.json'))
      @environment = WorldBank::Topic.find(6)
      a_get('topics/6?format=json').should have_been_made
      @environment.should be_a WorldBank::Topic
    end        
  
    context 'returned topic has' do
    
      before do
        stub_get('topics/6?format=json').
          to_return(:status => 200, :body => fixture('topic_6.json'))
        @environment = WorldBank::Topic.find(6)      
      end
      it 'name' do
        @environment.name.should eql 'Environment '
      end        
      
      it 'id' do
        @environment.id.should eql '6'
      end 
      
      it 'note' do
        @environment.note[0..20].should eql "Natural and man-made "  
      end      
    end
  end

end
