#!/usr/bin/env sh

# use -f to make the readlink path absolute
dirname="$(dirname -- "$(readlink -f -- "${0}")" )"

if [ "$dirname" = "." ]; then
   dirname="$PWD/$dirname"
fi

/usr/bin/wlr-randr | grep 'Transform:' | cut -d ':' -f 2 | sed -e 's/ //g' > "$dirname"/transform.txt
