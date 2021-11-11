# frozen_string_literal: true

require_relative '../../auto_inject/container'
require 'oj'

module Blockstream
  class GetUtxo
    include Import[
      request: 'blockstream.api.get'
    ]

    def call(address)
      resp = request.("/address/#{address}/utxo")
      Oj.load(resp)
    end
  end
end
