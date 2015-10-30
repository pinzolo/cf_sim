# 本来なら都道府県によって座標系が決定されるべきだが、とりあえず簡易的に最も近いものを対象とする
class CfSim::CordinationSystem
  attr_reader :latitude, :longitude

  ORIGIN_MAP = { 1  => [33.00000,129.30000],
                 2  => [33.00000,131.00000],
                 3  => [36.00000,132.10000],
                 4  => [33.00000,133.30000],
                 5  => [36.00000,134.20000],
                 6  => [36.00000,136.00000],
                 7  => [36.00000,137.10000],
                 8  => [36.00000,138.30000],
                 9  => [36.00000,139.50000],
                 10 => [40.00000,140.50000],
                 11 => [44.00000,140.15000],
                 12 => [44.00000,142.15000],
                 13 => [44.00000,144.15000],
                 14 => [26.00000,142.00000],
                 15 => [26.00000,127.30000],
                 16 => [26.00000,124.00000],
                 17 => [26.00000,131.00000],
                 18 => [20.00000,136.00000],
                 19 => [26.00000,154.00000] }

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def nearest_system_number
    @nearest_system_number ||= ORIGIN_MAP.min_by { |_, origin| distance(origin) }.first
  end

  def nearest_origin
    @nearest_origin ||= ORIGIN_MAP[nearest_system_number]
  end

  private

  def distance(origin)
    Math.sqrt((origin.first - @latitude) ** 2 + (origin.last - @longitude) ** 2)
  end
end
