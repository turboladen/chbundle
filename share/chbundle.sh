CHBUNDLE_VERSION="0.1.0"

function _chbundle_debug()
{
    msg=$(printf "DEBUG>>>>>>>>>>\n$1\nGUBED<<<<<<<<<<")
    if [[ -e $CHBUNDLE_DEBUG ]] ; then printf '%s\n' "$msg" ; fi ;
}

function chbundle_list()
{
    local_shell=`ps -o command -p $$`
    _chbundle_debug "$local_shell"

    case "$local_shell" in
        *zsh*)
            setopt extendedglob
            gemfiles=`ls -d Gemfile^*lock` 2> /dev/null
            ;;
        *bash*)
            gemfiles=`GLOBIGNORE="*.lock" ls Gemfile* 2> /dev/null`
            ;;
        *)
            printf "Not sure how to behave with this shell: $local_shell\n"
            return 1
            ;;
    esac

    bundles=`echo "$gemfiles" | cut -f2 -d"."`
    printf "chbundle v$CHBUNDLE_VERSION\n"

    # Print bundles if there are any.
    if [[ -n $bundles ]]
    then
        printf "bundles:\n"

        for bundle in $(printf "$bundles\n")
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

            printf "$prefix $bundle_name\n"
        done
    # Otherwise, let em know we didn't find any bundles.
    else
        printf "No bundles found.\n"
    fi
}

function chbundle_use()
{
    case "$1" in
        default) selected="Gemfile" ;;
        *)       selected="Gemfile.$1" ;;
    esac

    export BUNDLE_GEMFILE=$selected
    printf "Now using $BUNDLE_GEMFILE\n"
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
