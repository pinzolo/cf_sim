require 'test_helper'

class CfSim::ControlFieldSetFinderTest < Test::Unit::TestCase
  def setup
    @p1 = CfSim::Point.new('p1', 1, 1)
    @p2 = CfSim::Point.new('p2', 7, 1)
    @p3 = CfSim::Point.new('p3', 4, 7)
    @p4 = CfSim::Point.new('p4', 4, 4)
    @p5 = CfSim::Point.new('p5', 5, 2)
    @points = CfSim::PointList.new(@p1, @p2, @p3, @p4, @p5)
    @finder = CfSim::ControlFieldSetFinder.new(@points.creatable_fields)
  end

  test '合計面積が最大のフィールドセットを探す' do
    fields = @finder.find_max_area_fields
    assert_equal 7, fields.size
  end

  test '全てのフィールドセットを探す' do
    fields_list = @finder.find_all_fields_list
    assert_equal 2, fields_list.select { |fields| fields.size == 7 }.size
  end

  test '最大枚数となるフィールドセットを探す' do
    fields_list = @finder.find_max_count_fields_list
    assert_equal 2, fields_list.size
    assert fields_list.all? { |fields| fields.size == 7 }
  end

  test 'limit_field_countを指定した場合、特定枚数以下のフィールドセットは無視される' do
    finder = CfSim::ControlFieldSetFinder.new(@points.creatable_fields, @points.max_field_count / 2)
    fields_list = finder.find_all_fields_list
    assert fields_list.all? { |fields| fields.size >= @points.max_field_count / 2 }, "count: #{fields_list.map(&:size)}"
  end

  sub_test_case '実データテスト' do
    setup do
      @portals = [CfSim::Portal.new('理学４号館'        , 35.030753, 135.78338),
                  CfSim::Portal.new('火葬塚'            , 35.030531, 135.783129),
                  CfSim::Portal.new('数学科'            , 35.030138, 135.783282),
                  CfSim::Portal.new('久原像'            , 35.029862, 135.782506),
                  CfSim::Portal.new('北部食堂'          , 35.029818, 135.783629),
                  CfSim::Portal.new('理学６号館'        , 35.029528, 135.783048),
                  CfSim::Portal.new('理学図書館'        , 35.029295, 135.782846),
                  CfSim::Portal.new('後二條天皇北白河陵', 35.029105, 135.784466)]
      @points = CfSim::PointList.new(CfSim::PortalMap.new(@portals).points)
    end
    test 'find_max_count_fields_listテスト' do
      finder = CfSim::ControlFieldSetFinder.new(@points.creatable_fields)
      fields_list = finder.find_max_count_fields_list
      assert_equal 22, fields_list.size
      assert fields_list.all? { |fields| fields.size == 12 }
    end

    test 'find_max_area_fieldsテスト' do
      finder = CfSim::ControlFieldSetFinder.new(@points.creatable_fields)
      fields = finder.find_max_area_fields
      assert_in_delta fields.total_area, 43506.63104178156, 0.00001
    end

    test '最大枚数のフィールドセットは面積順で返す' do
      finder = CfSim::ControlFieldSetFinder.new(@points.creatable_fields)
      fields_list = finder.find_max_count_fields_list
      areas = fields_list.map(&:total_area)
      assert_equal areas, areas.sort.reverse
    end
  end
end

