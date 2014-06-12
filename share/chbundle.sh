CHBUNDLE_VERSION="0.1.0"

function chbundle_list()
{
    local_shell=`ps -o command -p $$`
    # If zshell
    case "$local_shell" in
      *zsh)
        setopt extendedglob
        gemfiles=`ls -d Gemfile^*lock`
        ;;
      *bash)
        gemfiles=`GLOBIGNORE="*.lock" && ls Gemfile*`
        ;;
      *)
        echo "Not sure how to behave with this shell: $local_shell"
        return 1
        ;;
    esac

    bundles=`echo "$gemfiles" | cut -f2 -d"."`
    echo "chbundle  version $CHBUNDLE_VERSION"
    echo "bundles:"

    for bundle in $(echo "$bundles")
    do
      if [[ "$bundle" == "Gemfile" ]]
        then
        echo "- default"
      else
        echo "- $bundle"
      fi
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
