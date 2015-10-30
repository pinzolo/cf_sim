require 'test_helper'

class CfSim::ControlFieldSetTest < Test::Unit::TestCase
  def setup
    @p1 = CfSim::Point.new('p1', 1, 1)
    @p2 = CfSim::Point.new('p2', 4, 1)
    @p3 = CfSim::Point.new('p3', 4, 5)
    @p4 = CfSim::Point.new('p4', 3, 3)
    @fields = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3),
                                         CfSim::ControlField.new(@p1, @p2, @p4),
                                         CfSim::ControlField.new(@p1, @p3, @p4),
                                         CfSim::ControlField.new(@p2, @p3, @p4))
  end

  test '面積の合計を取得' do
    assert_in_delta @fields.total_area, 12.0, 0.00001
  end

  test '空のリストの場合 empty? が true となる' do
    assert CfSim::ControlFieldSet.new.empty?
  end

  test '内部配列が等しい場合、等価である' do
    expected = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3),
                                          CfSim::ControlField.new(@p1, @p2, @p4),
                                          CfSim::ControlField.new(@p1, @p3, @p4),
                                          CfSim::ControlField.new(@p2, @p3, @p4))
    assert_equal expected, @fields
  end

  test '内部配列の順序が異なっていても等価である' do
    expected = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3),
                                          CfSim::ControlField.new(@p1, @p3, @p4),
                                          CfSim::ControlField.new(@p2, @p3, @p4),
                                          CfSim::ControlField.new(@p1, @p2, @p4))
    assert_equal expected, @fields
  end

  test 'ControleFieldList同士の減算が可能' do
    actual = @fields - CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3), CfSim::ControlField.new(@p1, @p2, @p4))
    expected = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p3, @p4), CfSim::ControlField.new(@p2, @p3, @p4))
    assert_equal expected, actual
  end

  test '配列との減算が可能' do
    actual = @fields - [CfSim::ControlField.new(@p1, @p2, @p3), CfSim::ControlField.new(@p1, @p2, @p4)]
    expected = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p3, @p4), CfSim::ControlField.new(@p2, @p3, @p4))
    assert_equal expected, actual
  end

  test 'ControleFieldList同士の和集合が可能' do
    fields1 = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3), CfSim::ControlField.new(@p1, @p2, @p4))
    fields2 = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p3, @p4), CfSim::ControlField.new(@p2, @p3, @p4))
    assert_equal @fields, fields1 + fields2
  end

  test '配列との和集合が可能' do
    fields1 = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3), CfSim::ControlField.new(@p1, @p2, @p4))
    fields2 = [CfSim::ControlField.new(@p1, @p3, @p4), CfSim::ControlField.new(@p2, @p3, @p4)]
    assert_equal @fields, fields1 + fields2
  end

  test 'ControleFieldList同士の積集合が可能' do
    actual = @fields & CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3),
                                                  CfSim::ControlField.new(@p1, @p2, @p4),
                                                  CfSim::ControlField.new(@p1, @p2, CfSim::Point.new('p5', 7, 7)))
    expected = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3), CfSim::ControlField.new(@p1, @p2, @p4))
    assert_equal expected, actual
  end

  test '配列との積集合が可能' do
    actual = @fields & [CfSim::ControlField.new(@p1, @p2, @p3), CfSim::ControlField.new(@p1, @p2, @p4), CfSim::ControlField.new(@p1, @p2, CfSim::Point.new('p5', 7, 7))]
    expected = CfSim::ControlFieldSet.new(CfSim::ControlField.new(@p1, @p2, @p3), CfSim::ControlField.new(@p1, @p2, @p4))
    assert_equal expected, actual
  end

  test 'clearで内包している要素を取り除く' do
    @fields.clear
    assert_empty @fields
  end
end
