# frozen_string_literal: true

require_relative '../../auto_inject/container'

module Blockstream
  class GetRawTx
    include Import[
      request: 'blockstream.api.get'
    ]

    def call(tx_id)
      raw_tx = request.("/tx/#{tx_id}/raw")
      Bitcoin::Protocol::Tx.new(raw_tx)
    end
  end
end
