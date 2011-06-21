module WorldBank

  module Query
  
    class Base
    
      def initialize(model)
        @model = model
        @client = WorldBank::Client.new
        @client.query[:dirs] << @model.type
      end

      #
      # the date param is expressed as a range 'StartDate:EndDate'
      # Date may be year & month, year & quarter, or just year
      # Date will convert any Date/Time object to an apporpriate year & month
      #
      def dates(date_range)
        if date_range.is_a? String
          @client.query[:params][:date] = date_range
        elsif date_range.is_a? Range
          start = date_range.first
          last = date_range.last
          @client.query[:params][:date] = "#{start.strftime("%YM%m")}:#{last.strftime("%YM%m")}"
        end
        self
      end

      def format(format, prefix=nil)
        @client.query[:params][:format] = format
        self
      end
      
      def id(id)
        @client.query[:params][:id] = id
        self
      end
      
      #
      # Most Recent Values param hs two optional params
      # Gap fill will specify how many items to add if there isn't enough data for you query
      # Frequency sets how frequent the data sets are...
      # An example is best to explain this:
      # I want the 5 most recent yearly values between 2000 and 2010,
      #   but I need at least three data sets to continue. My query would look like this:
      #   .dates('2000:2010').most_recent_values(:gap_fill => 3, :frequency => 'Y')
      #
      def most_recent_values(num, options={})
        @client.query[:params][:gapFill] = options[:gap_fill] if options[:gap_fill]
        @client.query[:params][:frequency] = options[:frequency] if options[:frequency]
        @client.query[:params][:MRV] = num
        self
      end
      
      def per_page(num)
        @client.query[:params][:perPage] = num
        self
      end
      
      def page(num)
        @client.query[:params][:page] = num
        self
      end
    
      def language(lang)
        @client.query[:dirs] << lang.to_s.downcase
        self
      end
      
      class Countries
        
        def lending_types(lend_type)
          parsed_array = lend_type.is_a?(Array) ? lend_type.map(&:id).join(';') : "lendingTypes=#{lend_type.id}"
          @client.query[:params][:lendingTypes] = parsed_array
          self
        end
        
        def income_level(income_level)
          parsed_array = income_type.map(&:id).join(';')
          @client.query[:params][:incomeLevel] = parsed_array
          self
        end
        
        def region(region)
          parsed_array = region.map(&:id).join(';')
          @client.query[:params][:region] = parsed_array
          self
        end
      
        class Indicators
          
          def countries(countries)
            parsed_array = countries.map(&:id).join(';')
            @client.query[:params][:countries] = parsed_array
            self
          end
        end
      end
    end
  end
end
