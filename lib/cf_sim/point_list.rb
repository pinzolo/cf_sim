require 'forwardable'

require 'cf_sim/control_field'
require 'cf_sim/control_field_set'

class CfSim::PointList
  extend Forwardable
  include Enumerable

  attr_reader :points
  def_delegators :@points, :clear, :each, :empty?, :hash, :size

  def initialize(*points)
    @points = points.flatten.freeze
  end

  def max_field_count
    @max_field_count ||= 3 * (points.length - 3) + 1
  end

  def creatable_field_count
    @creatable_field_count ||= points.combination(3).size
  end

  def creatable_fields
    @creatable_fields ||= CfSim::ControlFieldSet.new(points.combination(3).map { |a, b, c| CfSim::ControlField.new(a, b, c) })
  end

  def eql?(other)
    other.class == CfSim::PointList && @points == other.points
  end

  def ==(other)
    eql?(other)
  end
end
