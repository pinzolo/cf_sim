require 'cf_sim/control_field_set'

class CfSim::CoexistableFieldMap
  include Enumerable

  def initialize(fields)
    @map = fields.each_with_object({}) do |field, map|
      map[field] = CfSim::ControlFieldSet.new(fields.reject { |other| field == other || field.intersected?(other) })
    end
  end

  def [](field)
    @map[field]
  end

  def each
    @map.each { |field, coexistable_fields| yield field, coexistable_fields }
  end
end
