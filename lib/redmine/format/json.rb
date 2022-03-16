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
        @keys = [key, key.gsub(/s$/, '')]
      end

      def decode(json)
        response = nil
        @keys.each do |key|
          response = ActiveSupport::JSON.decode(json)[key]
          break unless response.nil?
        rescue StandardError => e
          # Nothing to see here
        end

        if response.nil?
          raise ActiveResource::InvalidRequestError, "JSON response did not contain #{@keys.join(' or ')}"
        end

        response
      end
    end
  end
end
