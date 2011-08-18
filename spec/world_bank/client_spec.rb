require 'helper'

describe WorldBank::Client do

  context 'get' do
    it 'returns the response from the specified path' do
      stub_get('sources/all?format=json').
        to_return(:status => 200, :body => fixture('sources.json'))
      client = WorldBank::Client.new( { :dirs => ['sources', 'all'],
                                        :params => {:format => 'json'}
                                      }, false)
      client.get('sources/all?format=json')
      a_get('sources/all?format=json').should have_been_made
    end
  end

end
