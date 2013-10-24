
module Baidu
  class Push
    def self.push_msg(data)
      body = { method: 'push_msg',
               message_type: 1,
               push_type: 3 }
      
      uri = Protocol.push_uri

      response = Baidu::Client.new.post(:channel, uri, body.merge(data))
    end
  end
end
