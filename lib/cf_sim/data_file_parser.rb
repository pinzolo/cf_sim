class CfSim::DataFileParser
  def initialize(data_file_path)
    @data_file_path = data_file_path
  end

  def parse
    @portals = []
    File.open(@data_file_path) do |file|
      file.each_line do |line|
        next if line.strip.empty?
        @portals << create_portal_from_line(line)
      end
    end
    @portals
  end

  private

  def create_portal_from_line(line)
    latitude, longitude, *rest = line.split(',')
    CfSim::Portal.new(rest.join(',').strip, latitude.to_f, longitude.to_f)
  end
end
