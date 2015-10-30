require 'test_helper'

class CfSim::PointListTest < Test::Unit::TestCase
  def setup
    @list = CfSim::PointList.new(CfSim::Point.new('p1', 1, 1),
                                 CfSim::Point.new('p2', 2, 2),
                                 CfSim::Point.new('p3', 3, 3),
                                 CfSim::Point.new('p4', 4, 4),
                                 CfSim::Point.new('p5', 5, 5))
  end

  test '座標数が 5 ならば max_field_count は 7 となる' do
    assert_equal 7, @list.max_field_count
  end

  test '座標数が 5 ならば creatable_field_count は 10 となる' do
    assert_equal 10, @list.creatable_field_count
  end

  test 'creatable_fields で作成可能なフィールドを取得する' do
    assert_empty @list.creatable_fields - [
      CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p2', 2, 2), CfSim::Point.new('p3', 3, 3)),
      CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p2', 2, 2), CfSim::Point.new('p4', 4, 4)),
      CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p2', 2, 2), CfSim::Point.new('p5', 5, 5)),
      CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p3', 3, 3), CfSim::Point.new('p4', 4, 4)),
      CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p3', 3, 3), CfSim::Point.new('p5', 5, 5)),
      CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p4', 4, 4), CfSim::Point.new('p5', 5, 5)),
      CfSim::ControlField.new(CfSim::Point.new('p2', 2, 2), CfSim::Point.new('p3', 3, 3), CfSim::Point.new('p4', 4, 4)),
      CfSim::ControlField.new(CfSim::Point.new('p2', 2, 2), CfSim::Point.new('p3', 3, 3), CfSim::Point.new('p5', 5, 5)),
      CfSim::ControlField.new(CfSim::Point.new('p2', 2, 2), CfSim::Point.new('p4', 4, 4), CfSim::Point.new('p5', 5, 5)),
      CfSim::ControlField.new(CfSim::Point.new('p3', 3, 3), CfSim::Point.new('p4', 4, 4), CfSim::Point.new('p5', 5, 5))
    ]
  end

  test '列挙可能である' do
    assert_equal ['p1', 'p2', 'p3', 'p4', 'p5'], @list.map(&:name)
  end

  test '空のリストの場合 empty? が true となる' do
    assert CfSim::PointList.new.empty?
  end

  test '内部配列が等しい場合、リストは等しい' do
    expected = CfSim::PointList.new(CfSim::Point.new('p1', 1, 1),
                                    CfSim::Point.new('p2', 2, 2),
                                    CfSim::Point.new('p3', 3, 3),
                                    CfSim::Point.new('p4', 4, 4),
                                    CfSim::Point.new('p5', 5, 5))
    assert_equal expected, @list
  end
end

