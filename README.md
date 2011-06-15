# The Code for America RubyGem template

If you want to create a new Code for America gem, you can use this gem as a template.
It's similar to [suspenders][suspenders], but for RubyGems instead of Rails.

[suspenders]: https://github.com/thoughtbot/suspenders

For more information on RubyGems, you should read the [RubyGems Manuals][manuals].

[manuals]: http://docs.rubygems.org/

After cloning this gem, you'll want to make the following changes:

1. Replace all instances of gem_template and GemTemplate with the snake_case and CamelCase name of your gem, respectively
2. Add a summary and description to the [gemspec][gemspec] file

[gemspec]: https://github.com/codeforamerica/gem_template/blob/master/gem_template.gemspec

This template includes:

* [RSpec][rspec] for isolation testing
* [SimpleCov][simplecov] for C0 code coverage
* [ZenTest][zentest] for continuous testing
* [YARD][yard] for documentation

[rspec]: https://github.com/rspec/rspec
[simplecov]: https://github.com/colszowka/simplecov
[zentest]: https://github.com/seattlerb/zentest
[yard]: https://github.com/lsegal/yard


[![Code for America Tracker](http://stats.codeforamerica.org/codeforamerica/gem_template.png)](http://stats.codeforamerica.org/projects/gem_template)