class CfSim::Portal
  attr_reader :name, :latitude, :longitude

  def initialize(name, latitude, longitude)
    @name = name
    @latitude = latitude
    @longitude = longitude
  end

  def ==(other)
    eql?(other)
  end

  def eql?(other)
    @name == other.name && @latitude == other.latitude && @longitude == other.longitude
  end

  def hash
    @name.hash + @latitude + @longitude
  end

  def to_s
    "#{name}(#{latitude}, #{longitude})"
  end
end
