# typed: strict
# frozen_string_literal: true

require 'active_resource'

module Redmine

  ##
  # This is the base class for this API.
  class Base < ActiveResource::Base
    class << self

      ##
      # Method to configure the API.
      def configure(&block)
        instance_eval(&block)
      end

      ##
      # Method to set the API key.
      def token=(token)
        return unless token

        (descendants + [self]).each do |resource|
          resource.headers['X-Redmine-API-Key'] = token
        end
      end

    end
  end

end
