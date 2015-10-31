require 'test_helper'

class CfSim::IntelMapUrlGeneratorTest < Test::Unit::TestCase
  def setup
    @portals = [CfSim::Portal.new('理学４号館'        , 35.030753, 135.78338),
                CfSim::Portal.new('火葬塚'            , 35.030531, 135.783129),
                CfSim::Portal.new('数学科'            , 35.030138, 135.783282),
                CfSim::Portal.new('久原像'            , 35.029862, 135.782506),
                CfSim::Portal.new('北部食堂'          , 35.029818, 135.783629),
                CfSim::Portal.new('理学６号館'        , 35.029528, 135.783048),
                CfSim::Portal.new('理学図書館'        , 35.029295, 135.782846),
                CfSim::Portal.new('後二條天皇北白河陵', 35.029105, 135.784466)]
    @portal_map = CfSim::PortalMap.new(@portals)
    @generator = CfSim::IntelMapUrlGenerator.new(@portal_map)
  end

  test 'ポータルのリンクを生成' do
    expected = 'https://www.ingress.com/intel?ll=35.030753,135.78338&pll=35.030753,135.78338'
    actual = @generator.portal_link(@portals.first)
    assert_equal expected, actual
  end

  test '多重CFのリンクを生成' do
    assert_nothing_raised do
      points = CfSim::PointList.new(@portal_map.points)
      finder = CfSim::ControlFieldSetFinder.new(points.creatable_fields)
      @generator.fields_link(finder.find_max_area_fields)
    end
  end
end
