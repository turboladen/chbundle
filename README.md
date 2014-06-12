chbundle
========

Gemfile switcher for projects that use multiple Gemfiles.


Features & Problems
-------------------

Features:

* Updates `$BUNDLE_GEMFILE`

Problems:

* `$BUNDLE_GEMFILE` gets set per shell.  If you `cd` to another project that
  doesn't have a bundle that's reflected in `$BUNDLE_GEMFILE`, you'll need to
  manually `chbundle` to a valid bundle.


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
chbundle  version 0.1.0
Bundles:
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

```
$ chbundle jruby
Now using Gemfile.jruby
$ echo $BUNDLE_GEMFILE
Gemfile.jruby
$ chbundle default
Now using Gemfile
$ echo $BUNDLE_GEMFILE
Gemfile
```
