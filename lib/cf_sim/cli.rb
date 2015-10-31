require 'thor'

class CfSim::CLI < Thor
  desc 'max_area DATA_FILE', 'print max area control fields URL.'
  def max_area(data_file)
    finder = load_finder_from(data_file)
    fields = finder.find_max_area_fields
    puts CfSim::IntelMapUrlGenerator.new.fields_link(fields, @portal_map)
  end

  desc 'max_count DATA_FILE', 'print max count control fields URL list.'
  def max_count(data_file)
    finder = load_finder_from(data_file)
    fields_list = finder.find_max_count_fields_list
    generator = CfSim::IntelMapUrlGenerator.new
    max_area = fields_list.first.total_area
    fields_list.each do |fields|
      area_rate = (fields.total_area * 100 / max_area).round(3)
      puts "#{generator.fields_link(fields, @portal_map)} (Area rate: #{area_rate})"
    end
  end

  private

  def load_finder_from(data_file)
    portals = CfSim::DataFileParser.new(data_file).parse
    @portal_map = CfSim::PortalMap.new(portals)
    CfSim::ControlFieldSetFinder.new(CfSim::PointList.new(@portal_map.points).creatable_fields)
  end
end

