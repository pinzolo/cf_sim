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
    @generator = CfSim::IntelMapUrlGenerator.new
  end

  test 'ポータルのリンクを生成' do
    expected = 'https://www.ingress.com/intel?ll=35.030753,135.78338&pll=35.030753,135.78338'
    actual = @generator.portal_link(@portals.first)
    assert_equal expected, actual
  end

  test '多重CFのリンクを生成' do
    expected = 'https://www.ingress.com/intel?ll=35.030753,135.78338&pls=35.030753,135.78338,35.029295,135.782846_35.029295,135.782846,35.029105,135.784466_35.029105,135.784466,35.030753,135.78338_35.030753,135.78338,35.029528,135.783048_35.029528,135.783048,35.029105,135.784466_35.030138,135.783282,35.029528,135.783048_35.029105,135.784466,35.030138,135.783282_35.030753,135.78338,35.030138,135.783282_35.029818,135.783629,35.029528,135.783048_35.029105,135.784466,35.029818,135.783629_35.030531,135.783129,35.029862,135.782506_35.029862,135.782506,35.029295,135.782846_35.029295,135.782846,35.030531,135.783129_35.029528,135.783048,35.029295,135.782846_35.030138,135.783282,35.029818,135.783629_35.030753,135.78338,35.030531,135.783129'
    portal_map = CfSim::PortalMap.new(@portals)
    points = CfSim::PointList.new(portal_map.points)
    finder = CfSim::ControlFieldSetFinder.new(points.creatable_fields)
    actual = @generator.fields_link(finder.find_max_area_fields, portal_map)
    assert_equal expected, actual
  end
end