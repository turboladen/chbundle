CHBUNDLE_VERSION="0.1.0"

function chbundle_list()
{
  bundles=`ls Gemfile*[^lock] | cut -f2 -d"."`
  echo "chbundle  version $CHBUNDLE_VERSION"
  echo "bundles:"

  for bundle in $bundles
  do
    echo "- $bundle"
  done
}

function chbundle_use()
{
  case "$1" in
      default) selected="Gemfile" ;;
      *)       selected="Gemfile.$1" ;;
  esac

  export BUNDLE_GEMFILE=$selected
  echo "Now using $BUNDLE_GEMFILE"
}

function chbundle()
{
    case "$1" in
        "")       chbundle_list ;;
        list)     chbundle_list ;;
        default)  chbundle_use "default" ;;
        *)        chbundle_use "$1"
    esac
}
