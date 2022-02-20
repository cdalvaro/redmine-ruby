# typed: strict
# frozen_string_literal: true

require 'redmine/base'
require 'redmine/format/json'

module Redmine

  ##
  # This class represents a Redmine user.
  class User < Redmine::Base
    has_many :issues
    has_many :groups
    self.format = Redmine::Format::JSON.new('users')
  end
end
