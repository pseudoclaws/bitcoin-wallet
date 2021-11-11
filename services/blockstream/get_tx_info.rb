# frozen_string_literal: true

require_relative '../../auto_inject/container'
require 'oj'

module Blockstream
  class GetTxInfo
    include Import[
      request: 'blockstream.api.get'
    ]

    def call(tx_id)
      resp = request.("/tx/#{tx_id}")
      Oj.load(resp)
    end
  end
end
