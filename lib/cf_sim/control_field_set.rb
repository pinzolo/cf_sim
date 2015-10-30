require 'forwardable'

class CfSim::ControlFieldSet
  extend Forwardable
  include Enumerable

  attr_reader :control_fields
  def_delegators :@control_fields, :clear, :each, :empty?, :hash, :size

  def initialize(*fields)
    @control_fields = fields.flatten.dup
  end

  def total_area
    @total_area ||= @control_fields.inject(0) { |area, field| area += field.area }
  end

  def -(fields)
    CfSim::ControlFieldSet.new(@control_fields - extract_field_array(fields))
  end

  def &(fields)
    CfSim::ControlFieldSet.new(@control_fields & extract_field_array(fields))
  end

  def +(fields)
    CfSim::ControlFieldSet.new(@control_fields + extract_field_array(fields))
  end

  def ==(other)
    eql?(other)
  end

  def eql?(other)
    other.class == CfSim::ControlFieldSet &&
      @control_fields.size == other.control_fields.size &&
      (@control_fields - other.control_fields).empty?
  end

  def dup
    # initialize 内で dup しているためここでする必要はない
    CfSim::ControlFieldSet.new(@control_fields)
  end

  def to_s
    text = "Fields:\n"
    @control_fields.each { |field| text << "  #{field}\n" }
    text << "Total area: #{total_area}"
    text
  end

  private

  def extract_field_array(fields)
    if fields.is_a?(Array)
      fields
    elsif fields.is_a?(CfSim::ControlFieldSet)
      fields.control_fields
    else
      raise 'Only for Array or ControlFieldSet'
    end
  end
end

