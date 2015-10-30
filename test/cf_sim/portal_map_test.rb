require 'test_helper'

class CfSim::PortalMapTest < Test::Unit::TestCase
  def setup
    @portal1 = CfSim::Portal.new('京都大学 数学科'  , 35.030138, 135.783282)
    @portal2 = CfSim::Portal.new('京都大学 北部食堂', 35.029818, 135.783629)
    @portal_map = CfSim::PortalMap.new(@portal1, @portal2)
  end

  test 'ポータルリストから直交座標に変換した座標リストを取得する' do
    assert_equal 2, @portal_map.points.size
    assert_in_delta(-107574.0059, @portal_map.points.first.x, 0.001)
    assert_in_delta(-19774.5715 , @portal_map.points.first.y, 0.001)
    assert_in_delta(-107609.5723, @portal_map.points.last.x , 0.001)
    assert_in_delta(-19742.9862 , @portal_map.points.last.y , 0.001)
  end

  test '変換後の座標を元に変換前のポータルを取得する' do
    assert_equal @portal1, @portal_map.find_portal(@portal_map.points.first)
  end

  test '変換前のポータルを元に変換後の座標を取得する' do
    assert_equal @portal_map.points.first, @portal_map.find_point(@portal1)
  end
end
