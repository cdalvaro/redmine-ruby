# typed: strict
# frozen_string_literal: true

require 'redmine/base'
require 'redmine/format/json'

module Redmine

  ##
  # This class represents a Redmine project.
  class Group < Redmine::Base
    has_many :users
    self.format = Redmine::Format::JSON.new('groups')
  end
end
