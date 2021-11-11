# frozen_string_literal: true

require_relative '../../auto_inject/container'
require 'bitcoin'

module Wallet
  class GetBalance
    include Import[
      get_utxo: 'blockstream.get_utxo'
    ]

    def call(address)
      utxo = get_utxo.(address)
      utxo.sum { |unspent| unspent['value'] }
    end

    private

    def funded_txo_sum(info)
      txo_sum(info, 'funded_txo_sum')
    end

    def spent_txo_sum(info)
      txo_sum(info, 'spent_txo_sum')
    end

    def txo_sum(info, field_name)
      info.dig('chain_stats', field_name)
    end
  end
end
