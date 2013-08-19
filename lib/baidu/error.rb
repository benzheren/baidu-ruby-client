module Baidu

  class BaiduError < StandardError #Exception ... why? A:http://www.skorks.com/2009/09/ruby-exceptions-and-exception-handling/
  end

  
  class BaiduProtocolError < BaiduError
    attr_accessor :code
    attr_accessor :error
    attr_accessor :response

    def initialize(response)
      @response = response
      if response
        @code = response["code"]
        @error = response["error"]
      end

      super("#{@code}: #{@error}")
    end

    def to_s
      @message || super
    end

    def message=(msg)
      @message = msg
    end
  end

end
