#!/usr/bin/env roundup

before() {
  source ./share/chbundle.sh
}

describe "zsh chbundle()"

testzsh() {
  /bin/zsh -c "source ./share/chbundle.sh; $1" ;
}
it_displays_the_title() {
  first_line=$(testzsh chbundle | head -n 1)
  test "$first_line" "=" "chbundle v0.1.0"
}

it_displays_no_bundles() {
  second_line=$(testzsh chbundle | tail -n 1)
  test "$second_line" "=" "No bundles found."
}
