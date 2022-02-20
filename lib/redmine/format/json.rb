# typed: strict
# frozen_string_literal: true

require 'activeresource'

module Redmine
  module Format
    # A general formatter for JSON
    #
    # @api private
    class JSON
      include ActiveResource::Formats::JsonFormat

      def initialize(key)
        super()
        @key = key
      end

      def decode(json)
        ActiveSupport::JSON.decode(json)[@key]
      end
    end
  end
end
