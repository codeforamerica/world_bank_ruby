module WorldBank

  class IncomeLevel
  
    def self.all
      WorldBank::Client.new.get('incomeLevels')
    end
  
  end

end
