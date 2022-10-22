# frozen_string_literal: true

module TEALrb
  class Algod
    def initialize(url: 'https://mainnet-api.algonode.cloud')
      @conn = Faraday.new(url: url)
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
