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
        @keys = [key, "#{key}s"]
      end

      def decode(json)
        response = nil
        @keys.each do |key|
          response = ActiveSupport::JSON.decode(json)[key]
          break unless response.nil?
        rescue
        end
        response
      end
    end
  end
end
