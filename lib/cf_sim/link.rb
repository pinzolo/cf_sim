class CfSim::Link
  attr_reader :source_point, :destination_point

  def initialize(source_point, destination_point)
    raise 'Cannot link to same point' if source_point == destination_point
    @source_point = source_point
    @destination_point = destination_point
  end

  def length
    @length ||= Math.sqrt((source_point.x - destination_point.x) ** 2 + (source_point.y - destination_point.y) ** 2)
  end

  def ==(other)
    eql?(other)
  end

  def eql?(other)
    (source_point == other.source_point && destination_point == other.destination_point) ||
      (source_point == other.destination_point && destination_point == other.source_point)
  end

  def hash
    source_point.hash + destination_point.hash
  end

  def intersected?(other)
    ta = (other.source_point.x - other.destination_point.x) * (source_point.y - other.source_point.y) + (other.source_point.y - other.destination_point.y) * (other.source_point.x - source_point.x)
    tb = (other.source_point.x - other.destination_point.x) * (destination_point.y - other.source_point.y) + (other.source_point.y - other.destination_point.y) * (other.source_point.x - destination_point.x)
    tc = (source_point.x - destination_point.x) * (other.source_point.y - source_point.y) + (source_point.y - destination_point.y) * (source_point.x - other.source_point.x)
    td = (source_point.x - destination_point.x) * (other.destination_point.y - source_point.y) + (source_point.y - destination_point.y) * (source_point.x - other.destination_point.x)
    tc * td < 0 && ta * tb < 0
  end

  def to_s
    "#{source_point}->#{destination_point}"
  end
end
