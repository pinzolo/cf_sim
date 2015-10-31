require 'test_helper'

class CfSim::DataFileParserTest < Test::Unit::TestCase
  def setup
    @portals = CfSim::DataFileParser.new('test/data_file.txt').parse
  end

  test 'ファイル内部のデータが読み取れている' do
    assert_equal 8, @portals.size
  end

  test '正しくフィールドが割り当てられている' do
    portal = @portals.first
    assert_equal '理学４号館', portal.name
    assert_equal 35.030753, portal.latitude
    assert_equal 135.78338, portal.longitude
  end

  test 'カンマが含まれたポータル名も読み取れている' do
    assert_equal '後二條天皇,北白河陵', @portals.last.name
  end
end
