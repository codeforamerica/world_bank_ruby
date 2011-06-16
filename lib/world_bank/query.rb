module WorldBank

  module Query
  
    class Base
    
      def dates(date_range)
        case date_range.instance_of?
          when String
            # pass date_range param
          when Range
            start = date_range.first
            last = date_range.last
            param = "#{start.strftime("%YM%m")}:#{last.strftime("%YM%m")}"
            # pass param param
      end
      
      def format(format, prefix=nil)
        case format.to_s.downcase
          when 'json'
            # register json parser
            # pass format param
          when 'jsonp'
            # register json parser
            # pass format and prefix params
          when 'xml'
            # register xml parser
            #pass format param
      end
      
      def id(id)
        # pass id param
      end
      
      def most_recent_values(num, options={})
        if options[:gap_fill]
          # pass gap_fill param
        end
        if options[:frequency]
          # pass frequency param
        end
        # pass num param
      end
      
      def per_page(num)
        # pass num param
      end
      
      def page(num)
        # pass num param
      end
    
      def language(lang)
        # pass lang param
      end
      
      class Countries
        
        def lending_types(lend_type)
          # pass lend_type param
        end
        
        def income_level(income_level)
          # pass income_level param
        end
        
        def region(region)
          # pass region param
        end
      
      end
      
      class Indicators
        extends WorldBank::Query::Countries
        
        def countries(countries)
          
        end
      end
    
    end
  end
