require "spec_helper"
require "graphr"

describe Graphr::Algorithms::ShortestPath do
  let (:nodes) { [{ id: 1 }, { id: 2 }, { id: 3 }] }
  let (:edges) { [{ from: 1, to: 2, weight: 4 }, { from: 2, to: 3, weight: 1 }] }
  let (:graph) { Graphr::Graph.new(nodes, edges) }

  let (:dot_file) { 'spec/fixtures/graph.dot' }
  let (:from_dot_graph) { Graphr::Graph.from_dot_file(dot_file) }

  let (:missing_path_dot_file) { 'spec/fixtures/graph2.dot' }

  context "interface" do
    subject { Graphr::Algorithms::ShortestPath.new(graph) }

    it { is_expected.to respond_to(:between) }
  end

  context "invalid inputs" do
    it "should raise when called with invalid nodes" do
      shortest_path = Graphr::Algorithms::ShortestPath.new(from_dot_graph)
      expect{ shortest_path.between("missing", "blank") }.to raise_error(Graphr::NodeNotFound)
    end

    it "should something when no path" do
      graph = Graphr::Graph.from_dot_file(missing_path_dot_file) 
      shortest_path = Graphr::Algorithms::ShortestPath.new(graph)

      expect { 
        shortest_path.between("4", "7") 
      }.to raise_error(Graphr::PathNotFound)
    end
  end

  context "finding paths" do
    it "should find the shortest path - test1" do
      shortest_path = Graphr::Algorithms::ShortestPath.new(graph)
      expect(shortest_path.between(1, 3)).to eq({ path: [1, 2, 3], distance: 5 })
    end

    it "should find the shortest path - test2" do
      shortest_path = Graphr::Algorithms::ShortestPath.new(from_dot_graph)

      expect(shortest_path.between("1", "3")).to eq({ path: ["1", "2", "3"], distance: 19 })
      expect(shortest_path.between("0", "7")).to eq({ path: ["0", "6", "7"], distance: 28 })
      expect(shortest_path.between("1", "7")).to eq({ path: ["1", "2", "3", "7"], distance: 28 })
    end
  end
end
