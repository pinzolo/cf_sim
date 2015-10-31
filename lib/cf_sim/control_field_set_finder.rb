require 'cf_sim/coexistable_field_map'
require 'cf_sim/control_field_set'

class CfSim::ControlFieldSetFinder
  def initialize(fields, options = {})
    @fields = CfSim::ControlFieldSet.new(fields.sort_by(&:area).reverse)
    @coexistable_field_map = CfSim::CoexistableFieldMap.new(@fields)
    @min_field_count = options[:min_field_count] || 1
    @limit_field_count = options[:limit_field_count] || nil
    @max_count_control_fields_list = []
    @max_area_control_fields = nil
  end

  def find_max_area_fields
    @max_area_control_fields = nil
    find_recursively(CfSim::ControlFieldSet.new, @fields, :max_area)
    @max_area_control_fields
  end

  def find_all_fields_list
    @control_fields_list = []
    find_recursively(CfSim::ControlFieldSet.new, @fields, :all)
    @control_fields_list
  end

  def find_max_count_fields_list
    @max_count_control_fields_list = []
    find_recursively(CfSim::ControlFieldSet.new, @fields, :max_count)
    @max_count_control_fields_list.sort_by(&:total_area).reverse
  end

  private

  def find_recursively(fields, coexistable_fields, type)
    return if ignore?(fields, coexistable_fields, type)

    if coexistable_fields.empty? || limit?
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
    when :all
      append_to_list(fields, @control_fields_list)
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
    field_count = fields.size + coexistable_fields.size
    case type
    when :max_area
      @max_area_control_fields && fields.total_area + coexistable_fields.total_area <= @max_area_control_fields.total_area
    when :all
      field_count < @min_field_count
    when :max_count
      field_count < @min_field_count && @max_count_control_fields_list.any? && field_count < @max_count_control_fields_list.first.size
    else
      false
    end
  end

  def limit?
    @limit_field_count && @max_count_control_fields_list && @max_count_control_fields_list.size == @limit_field_count
  end
end
