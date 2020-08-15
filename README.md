### How to use this gem?
Latest gem is released at [RubyGems.org](https://rubygems.org/gems/tnw_xml_parser)

Option 1: Add it to your `Gemfile` and run `bundle install`
```
# Gemfile

gem "tnw_xml_parser"

```

Option 2:
```
gem install tnw_xml_parser
```

### What does it do?
- This gem provides a ruby class called `TnwXmlParser` to do XML parsing.

### Usage Example

```
$ irb
> require "tnw_xml_parser"
=> true

> parser = TnwXmlParser.new("url_link_to_xml")
=> #<TnwXmlParser:0x00001asdf952913>

> parser.read_data

> parser.convert_to_hash
```
