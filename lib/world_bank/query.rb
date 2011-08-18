module WorldBank

  class Query

    attr_reader :pages, :total

    def initialize(name, id, model)
      @model = model
      @name = name
      @id = id
      @lang = false
      @raw = false
      @new = true
      @query = {:params => {:format => :json}, :dirs => []}
    end

    #
    # the date param is expressed as a range 'StartDate:EndDate'
    # Date may be year & month, year & quarter, or just year
    # Date will convert any Date/Time object to an apporpriate year & month
    #
    def dates(date_range)
      if date_range.is_a? String

        # assume the user knows what she is doing if passed a string
        @query[:params][:date] = date_range
      elsif date_range.is_a? Range
        start = date_range.first
        last = date_range.last
        @query[:params][:date] = "#{start.strftime("%YM%m")}:#{last.strftime("%YM%m")}"
      end
      self
    end

    def format(format)
      @query[:params][:format] = format
      self
    end

    def raw
      @raw = true
      self
    end

    def id(id)
      @query[:params][:id] = id
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
      @query[:params][:gapFill] = options[:gap_fill] if options[:gap_fill]
      @query[:params][:frequency] = options[:frequency] if options[:frequency]
      @query[:params][:MRV] = num
      self
    end

    def per_page(num=false)
      if num
        @query[:params][:perPage] = num
        self
      else
        @per_page || @query[:params][:per_page] || 50
      end
    end

    def page(num=false)
      if num
        @query[:params][:page] = num
        self
      else
        @page || @query[:params][:page]
      end
    end

    def next
      if @query[:params][:page].nil?
        @query[:params][:page] = 2
      else
        @query[:params][:page] += 1
      end
      self
    end

    def language(lang)
      if lang.length == 2
        @lang = lang.to_s.downcase
      else
        @lang = [ ['french', 'fr'],
          ['spanish', 'es'],
          ['english', 'en'],
          ['arabic', 'ar']  ].assoc(lang.to_s.downcase)[1]
      end
      self
    end

    def lending_types(lending_type)
      parsed = indifferent_number lending_type
      @query[:params].merge!({:lendingTypes => parsed})
      self
    end

    def income_levels(income_levels)
      parsed = indifferent_number income_levels
      @query[:params].merge!({:incomeLevels => parsed})
      self
    end

    def regions(regions)
      parsed = indifferent_number regions
      @query[:params].merge!({:countries => parsed})
      self
    end

    def country(country)
      parsed = indifferent_type country
      parsed = ensure_country_id parsed
      @query[:params].merge!({:countries => parsed})
      self
    end

    def indicators(indicators)
      parsed = indifferent_number indicators
      @query[:params].merge!({:indicators => parsed})
      self
    end

    def featured_indicators
      @query[:params].merge!({:featured => 1})
      self
    end

    def sources(sources)
      parsed = indifferent_number sources
      @query[:params].merge!({:sources => parsed})
      self
    end

    def cycle
      @cycle_results = @pages.nil? ? [] : fetch
      (@pages - @page).times do
        @cycle_results += self.next.fetch
      end
      @cycle_results
    end

    def fetch
      if @new
        @query[:dirs].push @name
        @query[:dirs].push @id
        @query[:dirs].unshift @lang if @lang
        @query[:params][:format] ||= :json
        @new = false
      end
      client = WorldBank::Client.new(@query, @raw)
      results = client.get_query
      results = parse results unless @raw
      results
    end

private

    def parse(results)
      update_fetch_info(results[0])
      if @id =~ /all/ || @model == WorldBank::Data
        results = results[1].map { |result| @model.new result }
      else
        results = @model.new results[1][0]
      end
      results
    end

    def update_fetch_info(meta_info)
      @page = meta_info['page'].to_i
      @per_page = meta_info['per_page'].to_i
      @pages = meta_info['pages'].to_i
      @total = meta_info['total'].to_i
    end

    def indifferent_number(possibly_multiple_args)
      parsed = if possibly_multiple_args.is_a?(Array)
        arr = possibly_multiple_args.map do |arg|
          indifferent_type(arg)
        end
        arr.join(';')
      else
        indifferent_type(possibly_multiple_args)
      end
      parsed
    end

    def indifferent_type(arg)
      parsed = ''
      unless arg.is_a?(String) || arg.is_a?(Numeric)
        parsed = arg.id
      else
        parsed = arg
      end
      parsed
    end

    def ensure_country_id(id)
      @country_id = id
      if @country_id.length > 3
        @matching = WorldBank::Country.country_aliases.select do |country|
          country[2] =~ Regexp.new(@country_id)
        end
        if @matching.length > 1
          raise ArgumentError,
            "More than one country code matched '#{@country_id}'. Perhaps you meant one of #{@matching.join(', ')}?",
            caller
        elsif @matching.length == 0
          raise ArgumentError,
            "No countries matched '#{@country_id}', please try again.",
            caller
        else
          @country_id = @matching[0][0]
        end
      end
      @country_id
    end

    def indifferent_nums(args)
      parsed = ''
      if args.is_a? Array
        parsed = args.map! do |arg|
          arg = normalize_country_id arg
          arg = ensure_country_id arg
        end.join(';')
      else
        args = normalize_country_id args
        parsed = ensure_country_id args
      end
      parsed
    end

    def normalize_country_id(id)
        id.gsub!(/[ -]/, '_')
        id.downcase
    end
  end
end

