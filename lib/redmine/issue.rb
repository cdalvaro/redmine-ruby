# typed: strict
# frozen_string_literal: true

require 'redmine/base'
require 'redmine/format/json'

module Redmine
  ##
  # This class represents a Redmine issue/task.
  class Issue < Redmine::Base
    self.format = Redmine::Format::JSON.new('issues')
  end
end
