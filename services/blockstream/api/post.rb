# frozen_string_literal: true

require 'net/http'
require_relative 'base'

module Blockstream
  module Api
    class Post < Blockstream::Api::Base
      def call(url, data)
        uri = uri(url)
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri.path)

        https.request(request, data)
      end
    end
  end
end
