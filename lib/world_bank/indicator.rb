module WorldBank

  class Indicator
  
    def self.all
      WorldBank::Client.new.get('indicators')
    end
  
  end

end
