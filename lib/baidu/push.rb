
module Baidu
  class Push
    def self.push_msg(data)
      body = data.merge({ method: 'push_msg', message_type: 1 })
      uri = Protocol.push_uri

      response = Baidu.client.post(:channel, uri, body)
    end
  end
end
