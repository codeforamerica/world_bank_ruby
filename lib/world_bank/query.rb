module WorldBank

  class Query

    def initialize(name, id, model)
      @model = model
      @client = WorldBank::Client.new
      @name = name
      @id = id
      @lang = false
      @raw = false
    end

    #
    # the date param is expressed as a range 'StartDate:EndDate'
    # Date may be year & month, year & quarter, or just year
    # Date will convert any Date/Time object to an apporpriate year & month
    #
    def dates(date_range)
      if date_range.is_a? String

        # assume the user knows what she is doing if passed a string
        @client.query[:params][:date] = date_range
      elsif date_range.is_a? Range
        start = date_range.first
        last = date_range.last
        @client.query[:params][:date] = "#{start.strftime("%YM%m")}:#{last.strftime("%YM%m")}"
      end
      self
    end

    def format(format)
      @client.query[:params][:format] = format
      self
    end

    def raw
      @raw = true
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
      @lang = lang.to_s.downcase
      self
    end

    def lending_types(lending_type)
      parsed = indifferent_number lending_types
      @client.query[:dirs].unshift parsed
      @client.query[:dirs].unshift 'lendingTypes'
      self
    end

    def income_levels(income_levels)
      parsed = indifferent_number income_levels
      @client.query[:dirs].unshift parsed
      @client.query[:dirs].unshift 'incomeLevels'
      self
    end

    def regions(regions)
      parsed = indifferent_number regions
      @client.query[:dirs].unshift parsed
      @client.query[:dirs].unshift 'countries' 
      self
    end

    def countries(countries)
      parsed = indifferent_number countries
      @client.query[:dirs].unshift parsed
      @client.query[:dirs].unshift 'countries'
      self
    end

    def indicators(indicators)
      parsed = indifferent_number indicators
      @client.query[:dirs].unshift parsed
      @client.query[:dirs].unshift 'indicators'
      self
    end

    def fetch
      @client.query[:dirs].push @name
      @client.query[:dirs].push @id
      @client.query[:dirs].unshift @lang if @lang
      results = @client.get_query
      results = parse results unless @raw
      results
    end

private

    def parse(results)
      if @id =~ /all/
        results = results[1].map { |result| @model.new result } unless @raw
      else
        results = @model.new results[1][0] unless @raw
      end
      results
    end

    def indifferent_number(possibly_multiple_args)
      if possibly_multiple_args.is_a?(Array)
        possibly_multiple_args.map do |arg| 
          indifferent_type(arg)
        end.join(';')
      else
        indifferent_type(possibly_multiple_args)
      end
    end

    def indifferent_type(arg)
      if arg.is_a?(::WorldBank)
        arg.id
      else
        arg
      end
    end
  end
end

