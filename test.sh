#!/bin/bash
set -e
set -o pipefail

ERRORS=()
FILES=$(find . \( -path ./vim/plugged -o -path ./.git \) -prune -o -type f -print | sort -u)

# run `shellcheck` on all shell files
for f in ${FILES}; do
	if file "$f" | grep --quiet shell; then
		{
			shellcheck "$f" && echo "[OK]: sucessfully linted $f"
		} || {
			# add to errors
			ERRORS+=("$f")
		}
	fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "No errors, hooray"
else
	echo "These files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi
