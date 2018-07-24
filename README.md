# 🌳 Rooted

[![Gem Version](https://badge.fury.io/rb/rooted.png)](http://badge.fury.io/rb/rooted)
[![Build Status](https://travis-ci.org/seblindberg/ruby-rooted.svg?branch=master)](https://travis-ci.org/seblindberg/ruby-rooted)
[![Inline docs](http://inch-ci.org/github/seblindberg/ruby-rooted.svg?branch=master)](http://inch-ci.org/github/seblindberg/ruby-rooted)
[![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/gems/rooted/)

This gem implements a _rooted, ordered tree_, but that name is a bit of a mouthful. It is ment to be used as a building block when working with any tree shaped data. For a brief recap of the terminology please see below. Please refer to https://en.wikipedia.org/wiki/Tree_structure for a more in depth description.

           A     A is the root.
      ┌────┼──┐  B, C and D are all children of A.
      B    C  D  E is a descendant of A.
    ┌─┼─┐ ┌┴┐ │  A is of degree 3 while C is of degree 2.
    E F G H I J  F is a leaf.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rooted'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rooted

## Usage

Please see the documentation for the complete API.

```ruby
# Create some nodes
root = Rooted::Node.new
child_a = Rooted::Node.new
child_b = Rooted::Node.new

# Put the two children below the root
root << child_a << child_b

# Look at the result
p root # => Rooted::Node:0x3fd5d54efda0
       #    ├─╴Rooted::Node:0x3fd5d54c3ea8
       #    └─╴Rooted::Node:0x3fd5d54ba894
```

The gem is primarily ment to be extended by other classes. The following example builds a tree of the files in the file system and displays it much like the command line tool `tree`.

```ruby
class FileSystemItem < Rooted::Node
  def display
    inspect { |item| item.value }
  end

  def self.map_to_path path = '.', root: new(path)
    # Iterate over all of the files in the directory
    Dir[path + '/*'].each do |entry|
      # Create a new FileSystemItem for the entry
      item = new File.basename(entry)
      root << item
      # Continue to map the files and directories under
      # entry, if it is a directory
      map_to_path entry, root: item unless File.file? entry
    end

    root
  end
end

puts FileSystemItem.map_to_path('.').display
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rooted.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

