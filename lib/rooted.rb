# frozen_string_literal: true

require 'forwardable'
require 'linked'

require 'rooted/version'
require 'rooted/mutable'
require 'rooted/node'
require 'rooted/tree'

# A basic implementation of a tree data structure.
module Rooted
  class StructureException < StandardError; end

  private_constant :Mutable
end
