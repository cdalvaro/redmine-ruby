# typed: strict
# frozen_string_literal: true

require 'redmine/base'
require 'redmine/format/json'

module Redmine

  ##
  # This class represents a Redmine issue/task.
  class Issue < Redmine::Base
    ENDPOINT = 'issues'
    private_constant :ENDPOINT

    attr_reader :url

    self.format = Redmine::Format::JSON.new(ENDPOINT)

    def initialize(attributes, persisted)
      parse_datetime(attr: attributes, field: :start_date, format: '%Y-%m-%d')
      parse_datetime(attr: attributes, field: :due_date, format: '%Y-%m-%d')
      parse_datetime(attr: attributes, field: :created_on)
      parse_datetime(attr: attributes, field: :updated_on)
      get_user(attr: attributes, field: :author)
      get_user(attr: attributes, field: :assigned_to)
      super(attributes, persisted)

      @url = URI.join(Redmine::Base.site, "#{ENDPOINT}/", id.to_s)
    end

    private

    ##
    # Converts the given date to a DateTime object for the given field.
    #
    # @param attr [Hash] The attributes.
    # @param field [Symbol] The field name.
    # @param format [String] The format. Default to: '%Y-%m-%dT%H:%M:%SZ'.
    def parse_datetime(attr:, field:, format: '%Y-%m-%dT%H:%M:%SZ')
      field = field.to_s
      attr[field] = DateTime.strptime(attr[field], format) if attr.include?(field)
    rescue StandardError => e
      puts "Error parsing date for field #{field}: #{e.message}"
    end

    ##
    # Converts the user from the given field to a User object.
    #
    # @param attr [Hash] The attributes.
    # @param field [Symbol] The field name.
    def get_user(attr:, field:)
      field = field.to_s
      if attr.include?(field)
        user = Redmine::User.find(attr[field]['id'])
        attr[field] = user unless user.nil?
      end
    rescue StandardError => e
      puts e.message
    end

  end
end
