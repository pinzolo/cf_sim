require 'coveralls'
require 'simplecov'
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '/test/'
  add_filter '/bundle/'
  add_filter do |source_file|
    source_file.filename != 'cblxy.rb'
  end
end

require 'test/unit'
require 'cf_sim'
