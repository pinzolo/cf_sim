require 'cf_sim/link'

class CfSim::ControlField
  attr_reader :point1, :point2, :point3, :link1, :link2, :link3

  def initialize(point1, point2, point3)
    @point1, @point2, @point3 = point1, point2, point3
    @link1 = CfSim::Link.new(point1, point2)
    @link2 = CfSim::Link.new(point2, point3)
    @link3 = CfSim::Link.new(point3, point1)
  end

  def ==(other)
    eql?(other)
  end

  def eql?(other)
    (points - other.points).empty?
  end

  def hash
    point1.hash + point2.hash + point3.hash
  end

  def points
    @points ||= [@point1, @point2, @point3].freeze
  end

  def links
    @links ||= [@link1, @link2, @link3].freeze
  end

  def area
    @area ||= calculate_area
  end

  def intersected?(other)
    links.any? do |link1|
      other.links.any? do |link2|
        link1.intersected?(link2)
      end
    end
  end

  def to_s
    "#{point1.name} -> #{point2.name} -> #{point3.name}"
  end

  private

  def calculate_area
    s = links.map(&:length).inject(:+) / 2.0
    Math.sqrt(s * (s - link1.length) * (s - link2.length) * (s - link3.length))
  end
end
