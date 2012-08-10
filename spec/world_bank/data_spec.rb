require 'helper'

describe WorldBank::Data do
  context "cycle" do
    it "cycles through 2 pages of results for data query on all countries, specific indicator" do
      2.times do |i|
        request_string = "countries/all/indicators/SP.POP.TOTL?page=#{i+1}&format=json"
        stub_get(request_string).
          to_return(:status => 200, :body => ["#{i+1}"])
      end
      query = WorldBank::Data.country('all').indicator('SP.POP.TOTL').raw.page(1)
      query.instance_variable_set(:@pages, 2)
      query.cycle.should == ["2"]            
    end
    it "cycles through all 5 pages of results for data query on all countries, specific indicator" do
      5.times do |i|
        request_string = "countries/all/indicators/SP.POP.TOTL?page=#{i+1}&format=json"
        stub_get(request_string).
          to_return(:status => 200, :body => ["#{i+1}"])
      end
      query = WorldBank::Data.country('all').indicator('SP.POP.TOTL').raw.page(1)
      query.instance_variable_set(:@pages, 5)
      query.cycle.should == ["2", "3", "4", "5"]
    end
  end
end