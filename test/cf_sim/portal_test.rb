require 'test_helper'

class CfSim::PortalTest < Test::Unit::TestCase
  def setup
    @portal = CfSim::Portal.new('test', 1, 2)
  end

  test '同じ座標かつ同じ名前ならば CfSim::Portal は等しい' do
    assert_equal CfSim::Portal.new('test', 1, 2), @portal
  end

  test 'x座標が異なれば CfSim::Portal は異なる' do
    assert @portal != CfSim::Portal.new('test', 2, 2)
  end

  test 'y座標が異なれば CfSim::Portal は異なる' do
    assert @portal != CfSim::Portal.new('test', 1, 1)
  end

  test 'x座標、y座標ともに異なれば CfSim::Portal は異なる' do
    assert @portal != CfSim::Portal.new('test', 1, 1)
  end

  test '名称が異なれば CfSim::Portal は異なる' do
    assert @portal != CfSim::Portal.new('other', 1, 2)
  end
end

