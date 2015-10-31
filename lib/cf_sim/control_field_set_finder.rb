require 'cf_sim/coexistable_field_map'
require 'cf_sim/control_field_set'

class CfSim::ControlFieldSetFinder
  def initialize(fields, options = {})
    @fields = CfSim::ControlFieldSet.new(fields.sort_by(&:area).reverse)
    @coexistable_field_map = CfSim::CoexistableFieldMap.new(@fields)
    @limit_field_count = options[:limit_field_count] || nil
    @max_count_control_fields_list = []
    @max_area_control_fields = nil
  end

  def find_max_area_fields
    @max_area_control_fields = nil
    find_recursively(CfSim::ControlFieldSet.new, @fields, :max_area)
    @max_area_control_fields
  end

  def find_max_count_fields_list
    @max_count_control_fields_list = []
    find_recursively(CfSim::ControlFieldSet.new, @fields, :max_count)
    all_list = @max_count_control_fields_list.sort_by(&:total_area).reverse
    @limit_field_count ? all_list[0...@limit_field_count] : all_list
  end

  private

  def find_recursively(fields, coexistable_fields, type)
    return if ignore?(fields, coexistable_fields, type)

    if coexistable_fields.empty?
      deploy(fields, type)
    else
      coexistable_fields.each do |field|
        find_recursively(fields + [field], coexistable_fields & (@coexistable_field_map[field].reject { |f| f.area > field.area }) , type)
      end
    end
  end

  def deploy(fields, type)
    case type
    when :max_area
      replace_if_max(fields)
    when :max_count
      append_or_create_if_max_count(fields)
    end
  end

  def replace_if_max(fields)
    @max_area_control_fields = fields if @max_area_control_fields.nil? || fields.total_area > @max_area_control_fields.total_area
  end

  def append_to_list(fields, fields_list)
    fields_list << fields unless fields_list.include?(fields)
  end

  def append_or_create_if_max_count(fields)
    if @max_count_control_fields_list.empty? || @max_count_control_fields_list.first.size == fields.size
      append_to_list(fields, @max_count_control_fields_list)
    elsif @max_count_control_fields_list.first.size < fields.size
      @max_count_control_fields_list = [fields]
    end
  end

  def ignore?(fields, coexistable_fields, type)
    case type
    when :max_area
      @max_area_control_fields && fields.total_area + coexistable_fields.total_area <= @max_area_control_fields.total_area
    when :max_count
      @max_count_control_fields_list.any? && fields.size + coexistable_fields.size < @max_count_control_fields_list.first.size
    else
      false
    end
  end
end
