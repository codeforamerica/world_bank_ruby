module WorldBank

  class Source
  
    def self.all
      WorldBank::Client.new.get('sources')
    end
  
  end

end
