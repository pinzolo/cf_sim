require 'test_helper'

class CfSim::ControlFieldTest < Test::Unit::TestCase
  def setup
    @cf = CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p2', 4, 1), CfSim::Point.new('p3', 4, 5))
  end

  test 'CfSim::ControlField#points は頂点座標を配列で返す' do
    expected = [CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p2', 4, 1), CfSim::Point.new('p3', 4, 5)]
    assert_equal expected, @cf.points
  end

  test 'CfSim::ControlField#links は辺となるリンクを配列で返す' do
    expected = [CfSim::Link.new(@cf.point1, @cf.point2), CfSim::Link.new(@cf.point2, @cf.point3), CfSim::Link.new(@cf.point3, @cf.point1)]
    assert_equal expected, @cf.links
  end

  test '同じ座標を結んだフィールド同士は等しい' do
    expected = CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p2', 4, 1), CfSim::Point.new('p3', 4, 5))
    assert_equal expected, @cf
  end

  test '同じ座標を結んだフィールド同士は作成時の座標指定の順序が異なっても等しい' do
    expected = CfSim::ControlField.new(CfSim::Point.new('p1', 4, 1), CfSim::Point.new('p2', 4, 5), CfSim::Point.new('p3', 1, 1))
    assert_equal expected, @cf
  end

  test '同じ座標を結んでいないフィールド同士は異なる' do
    expected = CfSim::ControlField.new(CfSim::Point.new('p1', 4, 1), CfSim::Point.new('p2', 4, 5), CfSim::Point.new('p3', 1, 2))
    assert_not_equal expected, @cf
  end

  test 'CfSim::ControlField#area は面積を返す' do
    assert_equal 6.0, @cf.area
  end

  test '自身が内包するフィールドの場合、CfSim::ControlField#intersected? は false' do
    other = CfSim::ControlField.new(CfSim::Point.new('p1', 2, 2), CfSim::Point.new('p2', 3, 2), CfSim::Point.new('p3', 3, 3))
    assert_false @cf.intersected?(other)
  end

  test '自身が内包されるフィールドの場合、CfSim::ControlField#intersected? は false' do
    other = CfSim::ControlField.new(CfSim::Point.new('p1', 0, 0), CfSim::Point.new('p2', 5, 0), CfSim::Point.new('p3', 5, 8))
    assert_false @cf.intersected?(other)
  end

  test 'リンクを共有するフィールドで、リンクが交差しない場合 CfSim::ControlField#intersected? は false' do
    other = CfSim::ControlField.new(CfSim::Point.new('p1', 1, 1), CfSim::Point.new('p2', 0, 5), CfSim::Point.new('p3', 4, 5))
    assert_false @cf.intersected?(other)
  end

  test '2辺が交差するフィールド同士の場合、CfSim::ControlField#intersected? は true' do
    other = CfSim::ControlField.new(CfSim::Point.new('p1', 3, 2), CfSim::Point.new('p2', 3, 3), CfSim::Point.new('p3', 5, 3))
    assert @cf.intersected?(other)
  end

  test '4辺が交差するフィールド同士の場合、CfSim::ControlField#intersected? は true' do
    other = CfSim::ControlField.new(CfSim::Point.new('p1', 3, 2), CfSim::Point.new('p2', 3, 4), CfSim::Point.new('p3', 5, 3))
    assert @cf.intersected?(other)
  end

  test '6辺が交差するフィールド同士の場合、CfSim::ControlField#intersected? は true' do
    other = CfSim::ControlField.new(CfSim::Point.new('p1', 3, 0), CfSim::Point.new('p2', 2, 4), CfSim::Point.new('p3', 5, 3))
    assert @cf.intersected?(other)
  end

  test 'それぞれ独立したフィールド同士の場合、CfSim::ControlField#intersected? は false' do
    other = CfSim::ControlField.new(CfSim::Point.new('p1', 5, 1), CfSim::Point.new('p2', 5, 2), CfSim::Point.new('p3', 6, 1))
    assert_false @cf.intersected?(other)
  end
end
