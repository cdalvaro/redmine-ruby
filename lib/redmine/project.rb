# typed: strict
# frozen_string_literal: true

require 'redmine/base'
require 'redmine/format/json'

module Redmine

  ##
  # This class represents a Redmine project.
  class Project < Redmine::Base
    ENDPOINT = 'projects'
    private_constant :ENDPOINT

    has_many :issues

    self.format = Redmine::Format::JSON.new(ENDPOINT)
  end
end
