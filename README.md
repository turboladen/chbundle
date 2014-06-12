chbundle
========

Gemfile switcher for projects that use multiple Gemfiles.

Inspired, of course, by [chruby](https://github.com/postmodern/chruby).


Features & Problems
-------------------

Features:

* Updates `$BUNDLE_GEMFILE` so you don't have to
  `$BUNDLE_GEMFILE=Gemfile.different_things bundle install`.
* Supports bash and zsh.

Problems:

* `$BUNDLE_GEMFILE` gets set per shell.  If you `cd` to another project that
  doesn't have a bundle that's reflected in `$BUNDLE_GEMFILE`, you'll need to
  manually `chbundle` to a valid bundle.


You can, of course, just `export $BUNDLE_GEMFILE=Gemfile.neato` (which is what 
`chbundle` does for you) then `bundle install` (or whatever bundler command),
but that's **22** (* _gasp!_ *) more chars to type than `chbundle neato`!


Configuration
-------------

Add the following to the `~/.bashrc` or `~/.zshrc` file:

```
source /usr/local/share/chbundle/chbundle.sh
```

Use
---


### `chbundle list` ###

**Purpose:** List the available bundles.

```
$ chbundle list
chbundle v0.1.0
bundles:
*- default
 - jruby
 - rbx
```

...would be the result if you had the following Gemfiles:

* Gemfile
* Gemfile.jruby
* Gemfile.rbx


### `chbundle [bundle name]` ###

**Purpose:** Change to work in the context of `[bundle name]`.

*Example:* Change to work in the context of `Gemfile.jruby`.

```
$ chbundle jruby
Now using Gemfile.jruby
$ echo $BUNDLE_GEMFILE
Gemfile.jruby
$ bundle install
(goes and installs stuff based on Gemfile.jruby...)
```

*Example:* Change to work in the context of `Gemfile`.

```
$ chbundle default
Now using Gemfile
$ echo $BUNDLE_GEMFILE
Gemfile
$ bundle install
(goes and installs stuff based on Gemfile...)
```

Development
-----------

Tests are written using [roundup](http://bmizerany.github.io/roundup/), so get
that installed.
