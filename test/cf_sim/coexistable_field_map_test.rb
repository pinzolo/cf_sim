require 'test_helper'

class CfSim::CoexistableFieldMapTest < Test::Unit::TestCase
  def setup
    @p1 = CfSim::Point.new('p1', 1, 1)
    @p2 = CfSim::Point.new('p2', 7, 1)
    @p3 = CfSim::Point.new('p3', 4, 7)
    @p4 = CfSim::Point.new('p4', 4, 4)
    @p5 = CfSim::Point.new('p5', 5, 2)
    points = CfSim::PointList.new(@p1, @p2, @p3, @p4, @p5)
    @all_fields = points.creatable_fields
    @map = CfSim::CoexistableFieldMap.new(points.creatable_fields)
  end

  test '[(1,1), (7,1), (4,7)]は他の全てと共存できる' do
    field = CfSim::ControlField.new(@p1, @p2, @p3)
    actual = @map[field]
    expected = @all_fields - [field]
    assert_equal expected.size, actual.size
    assert_empty  actual - expected
  end

  test '[(7,1), (4,7), (5,2)]と[(7,1), (4,4)]のリンクを持つフィールドは共存できない' do
    field = CfSim::ControlField.new(@p2, @p3, @p5)
    actual = @map[field]
    expected = @all_fields - [field, CfSim::ControlField.new(@p2, @p3, @p4), CfSim::ControlField.new(@p2, @p4, @p5), CfSim::ControlField.new(@p2, @p4, @p1)]
    assert_equal expected.size, actual.size
    assert_empty  actual - expected
  end
end

