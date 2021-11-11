# frozen_string_literal: true

require 'dry-auto_inject'
require_relative 'auto_inject/container'

Dir['./services/**/*.rb'].each do |file|
  require File.expand_path(file, __dir__)
end

Container.namespace(:blockstream) do
  namespace(:api) do
    register :get, -> { Blockstream::Api::Get.new }
    register :post, -> { Blockstream::Api::Post.new }
  end
  register :get_address_info, -> { Blockstream::GetAddressInfo.new }
  register :get_raw_tx, -> { Blockstream::GetRawTx.new }
  register :get_tx_info, -> { Blockstream::GetTxInfo.new }
  register :get_utxo, -> { Blockstream::GetUtxo.new }
  register :post_tx, -> { Blockstream::PostTx.new }
end

Container.namespace(:validation) do
  register :validate_new, -> { Validation::ValidateNewCmd.new }
  register :validate_common, -> { Validation::ValidateCommonCmd.new }
end

Container.namespace(:wallet) do
  register :create_tx, -> { Wallet::CreateTransaction.new }
  register :get_balance, -> { Wallet::GetBalance.new }
end
