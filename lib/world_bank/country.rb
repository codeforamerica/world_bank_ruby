module WorldBank

  class Country
  
    def self.all
      WorldBank::Client.new.get('countries')
    end
  
  end

end
