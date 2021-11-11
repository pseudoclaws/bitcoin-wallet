# frozen_string_literal: true

require_relative 'api/get'
require_relative '../../auto_inject/container'
require 'oj'

module Blockstream
  class GetAddressInfo
    include Import[
      request: 'blockstream.api.get'
    ]

    def call(address)
      resp = request.("/address/#{address}")
      Oj.load(resp)
    end
  end
end
