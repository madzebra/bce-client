module BceClient
  class Address
    def initialize(address, rpc)
      @address = nil
      @address = address if (address.length == 34) && (address =~ /[^\w]+/).nil?
      @rpc = rpc
    end

    def valid?
      return false if @address.nil?
      result = @rpc.validateaddress @address
      result.nil? ? false : result['isvalid']
    end
  end
end
