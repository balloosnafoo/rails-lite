require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    attr_reader :cookie

    def initialize(req)
      match = req.cookies.select { |c| c.name == "_rails_lite_app" }.first
      cookie = JSON.parse(JSON.parse(match.to_json)["value"]) if match
      @cookie = cookie || { }
    end

    def [](key)
      cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      res.cookies << WEBrick::Cookie.new("_rails_lite_app", @cookie.to_json)
    end
  end
end
