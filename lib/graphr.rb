require "active_support"
require "active_support/core_ext/object"
require 'ruby-graphviz'

require "pry"
require "pry-nav"

require "graphr/graph"
require "graphr/version"
require "graphr/algorithms/shortest_path"


module Graphr
  class Error < StandardError; end
  class NodeNotFound < StandardError; end
  class DotFileNotFound < StandardError; end
  class PathNotFound < StandardError; end
  # Your code goes here...
end
