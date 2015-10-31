# CF Simulator
[![Build Status](https://travis-ci.org/pinzolo/cf_sim.svg)](http://travis-ci.org/pinzolo/cf_sim)
[![Coverage Status](https://coveralls.io/repos/pinzolo/cf_sim/badge.png)](https://coveralls.io/r/pinzolo/cf_sim)

ポータルを列挙したデータファイルから多重CFのURLを出力するシミュレータ

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cf_sim'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cf_sim

## Usage

### 指定のファイルに列挙されたポータルから作成できる最大面積の多重CFのURLを出力する

```sh
cf_sim max_area <data_file>
```

### 指定のファイルに列挙されたポータルから作成できる最大枚数の多重CFのURLを面積順に出力する

```sh
# あるだけ出力
cf_sim max_count <data_file>

# 面積の大きい順から10個出力
cf_sim max_count <data_file> 10
```

### ポータルデータファイルの書式

各行が `緯度,経度,ポータル名` の CSV ファイル（[参考](test/data_file.txt)）
ただし、ポータル名は必須ではない

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec cf_sim` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/pinzolo/cf_sim/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
