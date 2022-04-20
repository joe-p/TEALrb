# frozen_string_literal: true

module TEALrb
  module Opcodes
    module App
      def app_opted_in(account = nil, app = nil)
        TEAL.new [account.teal, app.teal, 'app_opted_in']
      end

      module Global
        extend App

        def self.current_application_address
          global 'CurrentApplicationAddress'
        end

        def self.latest_timestamp
          global 'LatestTimestamp'
        end
      end

      def global(field)
        TEAL.new ["global #{field}"]
      end
    end
  end
end
