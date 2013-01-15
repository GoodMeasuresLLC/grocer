module Grocer
  class Reply
    LENGTH = 6

    attr_accessor :identifier, :command, :status
    
    def error?
      status > 0
    end
    
    def describe
      {
        0 => "No Errors",
        1 => "Processing Error",
        2 => "Missing Device Token",
        3 => "Missing Topic",
        4 => "Missing Payload",
        5 => "Invalid Token Size",
        6 => "Invalid Topic Size",
        7 => "Invalid Payload Size",
        8 => "Invalid Token",
        255 => "None (Unknown)"
      }[status]
    end
    
    def initialize(binary_tuple)
      # C   =>  1 byte command
      # C   =>  1 byte statis
      # N   =>  4 byte identifier
      @command, @status, @identifier = binary_tuple.unpack("CCN")
      raise InvalidFormatError unless @command && @status && @identifier
    end
  end
end
