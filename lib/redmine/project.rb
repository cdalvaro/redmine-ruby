# typed: strict
# frozen_string_literal: true

require 'redmine/base'
require 'redmine/format/json'

module Redmine

  ##
  # This class represents a Redmine project.
  class Project < Redmine::Base
    has_many :issues
    self.format = Redmine::Format::JSON.new('projects')
  end
end
