# frozen_string_literal: true

module TEALrb
  class Algod
    def initialize(url: 'http://localhost:4001', token: 'a' * 64)
      @conn = Faraday.new(url) do |conn|
        conn.headers = { 'X-Algo-API-Token' => token }
      end
    end

    def compile(source, source_map: true)
      @conn.post('/v2/teal/compile') do |req|
        req.params['sourcemap'] = source_map
        req.body = source
        req.headers['Content-Type'] = 'text/plain'
      end
    end
  end
end
