# frozen_string_literal: true

require 'bitcoin'
require_relative '../../auto_inject/container'

module Wallet
  class CreateTransaction
    include Bitcoin::Builder
    include Import[
      tx: 'blockstream.get_raw_tx',
      tx_info: 'blockstream.get_tx_info',
      get_utxo: 'blockstream.get_utxo'
    ]

    def call(key, to, amount, fee)
      utxo = get_utxo.(key.addr)
      input_txs, unspent = input_txs(utxo, amount, fee)
      # create a new transaction (and sign the inputs)
      build_tx do |t|
        input_txs.each do |tx_info|
          prev_tx, prev_out_index = tx_with_index(tx_info['txid'], key.addr)
          t.input do |i|
            i.prev_out prev_tx
            i.prev_out_index prev_out_index
            i.signature_key key
          end
        end

        # add an output that sends some bitcoins to another address
        t.output do |o|
          o.value amount
          o.script { |s| s.recipient to }
        end

        remainder = unspent - amount - fee
        next if remainder.zero?

        t.output do |o|
          o.value remainder
          o.script { |s| s.recipient key.addr }
        end
      end
    end

    private

    def input_txs(utxo, amount, fee)
      unspent = 0
      input = []
      gross = amount + fee
      utxo.each do |tx|
        break if unspent >= gross

        input << tx
        unspent += tx['value']
      end
      [input, unspent]
    end

    def tx_with_index(tx_id, addr)
      [prev_tx(tx_id), prev_out_index(tx_id, addr)]
    end

    def prev_tx(id)
      tx.(id)
    end

    def prev_out_index(tx_id, addr)
      info = tx_info.(tx_id)
      info['vout'].find_index { |vout| vout['scriptpubkey_address'] == addr }
    end
  end
end
