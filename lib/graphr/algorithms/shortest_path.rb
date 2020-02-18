module Graphr
  module Algorithms
    class ShortestPath

      MAX_DISTANCE = 2 ** (0.size * 8 - 2) - 1
      
      def initialize(graph)
        @graph = graph

        @visited = []
        @unvisited = []
        @paths = { }
      end

      def between start_node, target_node
        raise Graphr::NodeNotFound if [start_node, target_node].any? { |id| @graph.find_node(id).blank? }
        @paths[start_node] = { distance: 0, prev: nil }

        @graph.each_node do |id, node|
          @unvisited << id
          @paths[id] = { distance: MAX_DISTANCE, prev: nil } if id != start_node
        end

        while @unvisited.length > 0 do
          min = get_min_distance_node
          current_node = min[0]
          current_distance = min[1]

          @graph.neighbours_for(current_node).each do |node|
            to_node = node[:id]
            distance_to_node = @graph.edge_between(current_node, to_node)[:weight]

            if distance_to_node + current_distance < @paths[to_node][:distance]
              @paths[to_node][:distance] = distance_to_node + current_distance
              @paths[to_node][:prev] = current_node
            end
          end

          @visited << current_node
          @unvisited.delete(current_node)
        end

        get_path start_node, target_node
      end

      private

      def get_path start, target
        shortest_path = [target]
        total_distance = @paths[target][:distance]

        while target != start do
          raise Graphr::PathNotFound if @paths[target][:prev].nil?
          shortest_path << @paths[target][:prev]
          target = @paths[target][:prev]
        end

        {
          path: shortest_path.reverse,
          distance: total_distance
        }
      end

      def get_min_distance_node
        min = @paths.slice(*@unvisited).sort_by{|k ,v| v[:distance]}.first
        [min[0], min[1][:distance]]
      end

    end
  end
end
