CHBUNDLE_VERSION="0.1.0"

function chbundle_list()
{
    local_shell=`ps -o command -p $$`

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

    # Print bundles if there are any.
    if [[ -n $bundles ]]
    then
        for bundle in $(echo "$bundles")
        do
            # Name the bundle 'default' if "Gemfile" is found.
            if [[ "$bundle" == "Gemfile" ]]
            then
                bundle_name="default"

                # If Bundler's ENV var is set...
                if [[ -e $BUNDLE_GEMFILE ]]
                then
                    # ...and it's set to "Gemfile"...
                    if [[ "Gemfile" == "$BUNDLE_GEMFILE" ]]
                    then
                        # then show that it's set.
                        prefix="*-"
                    else
                        # otherwise just show that it exists
                        prefix=" -"
                    fi
                # If Bundler's ENV var isn't set, show that "Gemfile" is default.
                else
                    prefix="*-"
                fi
            else
                bundle_name=$bundle

                # Show the currently set bundle.
                if [[ "$BUNDLE_GEMFILE" == *"$bundle" ]]
                then
                    prefix="*-"
                else
                    prefix=" -"
                fi
            fi

            echo "$prefix $bundle_name"
        done
    # Otherwise, let em know we didn't find any bundles.
    else
        echo "No bundles found."
    fi
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
