require 'helper'

describe WorldBank do
  context 'client' do
    it "is an instance of WorldBank::Client" do
      WorldBank.client.should be_a WorldBank::Client
    end
  end
end
