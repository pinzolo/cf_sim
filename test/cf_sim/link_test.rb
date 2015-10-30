require 'test_helper'

class CfSim::LinkTest < Test::Unit::TestCase
  test '(0,0), (3,4)を結ぶリンクの長さは5' do
    link = CfSim::Link.new(CfSim::Point.new('src', 0, 0), CfSim::Point.new('dest', 3, 4))
    assert_equal 5, link.length
  end

  test 'x軸に平行なリンクの長さも測れること' do
    link = CfSim::Link.new(CfSim::Point.new('src', 0, 0), CfSim::Point.new('dest', 1, 0))
    assert_equal 1, link.length
  end

  test 'y軸に平行なリンクの長さも測れること' do
    link = CfSim::Link.new(CfSim::Point.new('src', 0, 0), CfSim::Point.new('dest', 0, 1))
    assert_equal 1, link.length
  end

  test '同じ座標に対してリンクは張れない。例外となる' do
    assert_raise do
      CfSim::Link.new(CfSim::Point.new('src', 1, 1), CfSim::Point.new('dest', 1, 1))
    end
  end

  test '同じ座標を結んだリンクは等しい' do
    link1 = CfSim::Link.new(CfSim::Point.new('src1', 0, 0), CfSim::Point.new('dest1', 1, 1))
    link2 = CfSim::Link.new(CfSim::Point.new('src2', 0, 0), CfSim::Point.new('dest2', 1, 1))
    assert link1 == link2
  end

  test '同じ座標だが始点と終点が異なるリンクは等しい' do
    link1 = CfSim::Link.new(CfSim::Point.new('src1', 0, 0), CfSim::Point.new('dest1', 1, 1))
    link2 = CfSim::Link.new(CfSim::Point.new('src2', 1, 1), CfSim::Point.new('dest2', 0, 0))
    assert link1 == link2
  end

  test '異なる座標を結んだリンク同士は等しくない' do
    link1 = CfSim::Link.new(CfSim::Point.new('src1', 0, 0), CfSim::Point.new('dest1', 1, 1))
    link2 = CfSim::Link.new(CfSim::Point.new('src2', 0, 0), CfSim::Point.new('dest2', 1, 2))
    assert link1 != link2
  end

  test '交差するリンク同士では CfSim::Link#intersected? は true を返す' do
    link1 = CfSim::Link.new(CfSim::Point.new('src1', 0, 0), CfSim::Point.new('dest1', 5, 5))
    link2 = CfSim::Link.new(CfSim::Point.new('src1', 0, 5), CfSim::Point.new('dest1', 5, 0))
    assert link1.intersected?(link2)
  end

  test '交差しないリンク同士では CfSim::Link#intersected? は false を返す' do
    link1 = CfSim::Link.new(CfSim::Point.new('src1', 0, 0), CfSim::Point.new('dest1', 5, 5))
    link2 = CfSim::Link.new(CfSim::Point.new('src1', 5, 0), CfSim::Point.new('dest1', 5, 2))
    assert_false link1.intersected?(link2)
  end

  test 'リンク上に始点（終点）が存在するリンク同士では CfSim::Link#intersected? は false を返す' do
    link1 = CfSim::Link.new(CfSim::Point.new('src1', 0, 0), CfSim::Point.new('dest1', 5, 5))
    link2 = CfSim::Link.new(CfSim::Point.new('src1', 5, 0), CfSim::Point.new('dest1', 3, 3))
    assert_false link1.intersected?(link2)
  end

  test '始点（終点）を共有するリンク同士では CfSim::Link#intersected? は false を返す' do
    link1 = CfSim::Link.new(CfSim::Point.new('src1', 0, 0), CfSim::Point.new('dest1', 5, 5))
    link2 = CfSim::Link.new(CfSim::Point.new('src1', 5, 0), CfSim::Point.new('dest1', 5, 5))
    assert_false link1.intersected?(link2)
  end
end
