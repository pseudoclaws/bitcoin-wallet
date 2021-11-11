# frozen_string_literal: true

require 'uri'
require 'net/http'

module Blockstream
  module Api
    class Base
      BASE_URL = 'https://blockstream.info/testnet/api'

      protected

      def uri(url)
        URI.parse("#{BASE_URL}#{url}")
      end
    end
  end
end
