# frozen_string_literal: true

require 'net/http'
require_relative 'base'

module Blockstream
  module Api
    class Get < Blockstream::Api::Base
      def call(url)
        uri = uri(url)
        Net::HTTP.get(uri)
      end
    end
  end
end
