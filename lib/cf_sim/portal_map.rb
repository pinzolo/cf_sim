require 'cblxy'
require 'cf_sim/cordination_system'
require 'cf_sim/point'

class CfSim::PortalMap

  attr_reader :portals, :points

  def initialize(*portals)
    @portals = portals.flatten.dup.freeze
    @cordination_system = CfSim::CordinationSystem.new(@portals.first.latitude, @portals.first.longitude)
    @portal_map = {}
    @point_map = {}
    convert_to_points
  end

  def find_portal(point)
    @portal_map[point]
  end

  def find_point(portal)
    @point_map[portal]
  end

  private

  def convert_to_points
    @points = []
    @portals.each do |portal|
      point = convert_to_point(portal)
      @points << point
      @portal_map[point] = portal
      @point_map[portal] = point
    end
    @points.freeze
  end

  def convert_to_point(portal)
    x, y = blxy(convert_point_unit(portal.latitude), convert_point_unit(portal.longitude), @cordination_system.nearest_system_number)
    CfSim::Point.new(portal.name, x, y)
  end

  # 10進数による座標を、60進数（度分秒）に変換し 10000 倍する
  def convert_point_unit(point_unit)
    degree, rest = point_unit.divmod(1)
    minute, rest = (rest * 60).divmod(1)
    degree * 10000 + minute * 100 + rest * 60
  end
end
