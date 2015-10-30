class CfSim::Point
  attr_reader :name, :x, :y

  def initialize(name, x, y)
    @name = name
    @x, @y = x, y
  end

  def ==(other)
    eql?(other)
  end

  def eql?(other)
    @x == other.x && @y == other.y
  end

  def hash
    @x + @y
  end

  def to_s
    "#{name}(#{x}, #{y})"
  end
end
