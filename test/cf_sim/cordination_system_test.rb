require 'test_helper'

class CfSim::CordinationSystemTest < Test::Unit::TestCase
  def setup
    @cordination_system = CfSim::CordinationSystem.new(35, 135)
  end

  test '指定された緯度・経度に最も近い体系を取得する' do
    assert_equal 5, @cordination_system.nearest_system_number
  end

  test '指定された緯度・経度に最も近い原点を取得する' do
    assert_equal [36.00000,134.20000], @cordination_system.nearest_origin
  end
end
