module Graphr
  class Graph
    attr_accessor :nodes
    attr_accessor :edges

    def self.from_dot_file dot_file_path
      raise Graphr::DotFileNotFound, "#{dot_file_path} can't be found" unless File.exists?(dot_file_path)
      
      graph = GraphViz.parse(dot_file_path)

      nodes = []
      nodes = graph.each_node.map do |name, node|
        { id: name }
      end

      edges = graph.each_edge.map do |edge|
        {
          from: edge.node_one.gsub('"', ''),
          to: edge.node_two.gsub('"', ''),
          weight: edge[:label].output.gsub('"', '').to_i
        }
      end

      return new(nodes, edges)
    end

    def initialize(node_list, edge_list)
      @nodes = {}
      node_list.each do |n|
        @nodes[n[:id]] = n
      end

      @edges = edge_list 
    end

    def find_node id
      @nodes[id]
    end

    def neighbours_for id
      neighbour_ids = @edges.select { |edge| edge[:from] == id }.map { |edge| edge[:to] }

      @nodes.slice(*neighbour_ids).values
    end

    def each_node &block
      @nodes.each do |node_id, node|
        yield node_id, node
      end
    end

    def edge_between from, to
      @edges.find { |edge| edge[:from] == from && edge[:to] == to}
    end
  end
end
