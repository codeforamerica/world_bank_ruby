module WorldBank

  class LendingType
  
    def self.all
      WorldBank::Client.new.get('lendingTypes')
    end
  
  end

end
