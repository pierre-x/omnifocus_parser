# Omnifocus Parser (not ready for production, alpha release)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/omnifocus_parser`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation
Create a new Gemfile:

    $ bundle init

Then add this line to you Gemfile:
```ruby
gem 'omnifocus_parser', :git => 'https://github.com/pierre-x/omnifocus_parser.git'
```

Then execute:

    $ bundle install

## Usage

create a sample file test.rb:

```ruby
require "omnifocus_parser"

class OmnifocusParserTest 
  
  include OmnifocusParser

# contents.xml is not commited yet, because it contains my personnal TODO list
  def show_a_simple_parse
         self.xml_file= File.new('contents.xml')
         self.tree.root_nodes.each{|node| disp_node(node,0)}
  end       
         
end

parser = OmnifocusParserTest.new
parser.show_a_simple_parse
```

Then execute:

    $ bundle exec ruby test.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/omnifocus_parser.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
