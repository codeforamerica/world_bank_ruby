require File.expand_path(File.join(File.dirname(__FILE__), '/world_bank/client'))

module WorldBank
  
  def self.client(options={})
      WorldBank::Client.new(options)
    end

    # Delegate to WorldBank::Client.new
    def self.method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end

    def self.respond_to?(method, include_private=false)
      client.respond_to?(method, include_private) || super(method, include_private)
    end
    
end
