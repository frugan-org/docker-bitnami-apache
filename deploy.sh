#!/bin/bash

#https://blog.dockbit.com/templating-your-dockerfile-like-a-boss-2a84a67d28e9

deploy() {
	str="
  s!%%TAG%%!$TAG!g;
"

	sed -r "$str" "$1"
}

TAGS=(
	2.4
)

ENTRYPOINT=entrypoint.sh

IFS='
'
# shellcheck disable=SC2048
for TAG in ${TAGS[*]}; do

	if [ -d "$TAG" ]; then
		rm -Rf "$TAG"
	fi

	mkdir "$TAG"
	deploy Dockerfile.template >"$TAG"/Dockerfile

	if [ -f "$ENTRYPOINT" ]; then
		cp $ENTRYPOINT "$TAG"
	fi

done
