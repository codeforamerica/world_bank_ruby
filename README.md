# WorldBank

A wrapper for the World Bank's Development Indicators API sponsored by Code for America.

Please see the World Bank's data [[developer's page](http://data.worldbank.org/developers/)] for more info on the data sources.


Usage
-----
```ruby

	require 'world_bank'

  #
  # WorldBank will delegate to the client allowing top level look-ups of their catalog
  #
  WorldBank.sources               # =>  ['Doing Business', 'Something Else'...]
                                  #        array of 16 sources of information the bank used

  WorldBank.income_levels         # =>  { HIC: 'High Income', HPC: 'Heavily Indebted Poor Countries (HIPC)'...}
                                  #       hash of 9 income levels the bank assigns

  WorldBank.lending_types         # =>  [ { id: 'IBD', value: 'IBRD' }... ] an array of key: value pairs of 
                                  #        the 4 lending types

  WorldBank.topics                # =>  the 18 high level topics that indicators are grouped into
  WorldBank.regions               # =>
  WorldBank.countries             # =>  same as Country.all
  WorldBank.indicators            # =>  same as Indicator.all
  WorldBank.topics                # =>  same as Topic.all

  #
  # Topics
  #
  @environment = Topic.find(6)
  @environment.id                 # =>  6
  @environment.name               # =>  'Environment'
  @environment.note               # =>  'Natural and man-made environmental resources – fresh...'

  #
  # Countries
  #
  @brazil = Country.find('br')
  @brazil = Country.find('bra')
  @brazil.name                    # =>  'Brazil'
  #
  # note: only low and middle income countries are classified by region...
  #
  @brazil.region                  # =>  <WorldBank::Region @name="Latin America & Caribbean (all income levels)" ....>
  @brazil.capital                 # =>  'Brasilia'
  @brazil.lending_type            # => <WorldBank::LendingType>

  #
  # Indicators
  #
  @tractors = Indicator.find('AG.AGR.TRAC.NO')
  @tractors.id                    # =>  'AG.AGR.TRAC.NO'
  @tractors.name                  # =>  'Agricultural Machinery, tractors'
  @tractors.source                # =>  { id: 2, value: 'World Development Indicators' }

```


Contributing
------------
In the spirit of [free
software](http://www.fsf.org/licensing/essays/free-sw.html),
**everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments,
  clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](https://github.com/codeforamerica/world_bank_ruby/issues)
* by reviewing patches

Submitting an Issue
-------------------
We use the [GitHub issue
tracker](https://github.com/codeforamerica/fed_spending_ruby/issues) to track bugs and
features. Before submitting a bug report or feature request, check to
make sure it hasn't already
been submitted. You can indicate support for an existing issuse by
voting it up. When submitting a
bug report, please include a [Gist](https://gist.github.com/) that
includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem
version, Ruby version, and
operating system. Ideally, a bug report should include a pull request
with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100%
   documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100%
   covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec,
   version, or history file. (If you want to create your own version for
some reason, please do so in a separate commit.)

Copyright
---------
Copyright (c) 2011 Code for America
See
[LICENSE](https://github.com/codeforamerica/world_bank_ruby/blob/master/LICENSE.md)
for details.

[![Code for America
Tracker](http://stats.codeforamerica.org/codeforamerica/code_for_america_tracking.png)](http://stats.codeforamerica.org/)

