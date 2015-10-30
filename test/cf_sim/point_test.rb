require 'test_helper'

class CfSim::PointTest < Test::Unit::TestCase
  def setup
    @point = CfSim::Point.new('test', 1, 2)
  end

  test '同じ座標ならば CfSim::Point は等しい' do
    assert_equal CfSim::Point.new('other', 1, 2), @point
  end

  test 'x座標が異なれば CfSim::Point は異なる' do
    assert @point != CfSim::Point.new('other', 2, 2)
  end

  test 'y座標が異なれば CfSim::Point は異なる' do
    assert @point != CfSim::Point.new('other', 1, 1)
  end

  test 'x座標、y座標ともに異なれば CfSim::Point は異なる' do
    assert @point != CfSim::Point.new('other', 1, 1)
  end
end
