# frozen_string_literal: true

require_relative '../../auto_inject/container'

module Blockstream
  class PostTx
    include Import[
      request: 'blockstream.api.post'
    ]

    def call(transaction)
      hex = transaction.to_payload.bth
      resp = request.('/tx', hex)
      resp.body
    end
  end
end
