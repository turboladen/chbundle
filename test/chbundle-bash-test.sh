#!/usr/bin/env roundup

before() {
  source ./share/chbundle.sh
}

describe "bash chbundle()"

testbash() {
  /bin/bash -c "source ./share/chbundle.sh; $1" ;
}

it_displays_the_title() {
  first_line=$(testbash chbundle | head -n 1)
  test "$first_line" "=" "chbundle v0.1.0"
}

it_displays_no_bundles() {
  second_line=$(testbash chbundle | tail -n 1)
  test "$second_line" "=" "No bundles found."
}
