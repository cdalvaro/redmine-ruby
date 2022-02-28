# typed: strict
# frozen_string_literal: true

require 'redmine/base'
require 'redmine/format/json'

module Redmine
  ##
  # This class represents a Redmine issue/task.
  class Issue < Redmine::Base
    self.format = Redmine::Format::JSON.new('issue')

    def initialize(attributes, persisted)
      parse_datetime(attr: attributes, field: :start_date, format: '%Y-%m-%d')
      parse_datetime(attr: attributes, field: :due_date, format: '%Y-%m-%d')
      parse_datetime(attr: attributes, field: :created_on)
      parse_datetime(attr: attributes, field: :updated_on)
      get_user(attr: attributes, field: :author)
      get_user(attr: attributes, field: :assigned_to)
      super(attributes, persisted)
    end

    private

    def parse_datetime(attr:, field:, format: '%Y-%m-%dT%H:%M:%SZ')
      field = field.to_s
      attr[field] = DateTime.strptime(attr[field], format) if attr.include?(field)
    end

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
