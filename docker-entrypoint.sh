#!/bin/bash
set -e

#if [! -f "_config.yml"]; then
#    hexo init .
#fi

if [ "$(id -u)" = '0' ]; then
	find "${HEXO_FILE}" \! -user node -exec chown node '{}' +
	find "${ROOT_SSH_FILE}" \! -user node -exec chown node '{}' +
	exec su-exec node "${BASH_SOURCE}" "$@"
fi


#if [ "$(id -u)" = '1000' ]; then
#	find "${HEXO_FILE}" \! -user node -exec chown node '{}' +
#	find "${NODE_SSH_FILE}" \! -user node -exec chown node '{}' +
#	exec "${BASH_SOURCE}" "$@"
#fi


if [ ! -e "_config.yml" ]; then
	baseDir="${HEXO_FILE}.orig"
	for src in "${baseDir}"/*; do
		src="${src%/}"
		target="${HEXO_FILE}/${src#$baseDir/}"
		mkdir  -p "$(dirname "${target}")"
		if [ ! -e "${target}" ]; then
			tar -cC "$(dirname "${src}")" "$(basename "${src}")" | tar -xC "$(dirname "${target}")"
		fi
	done
fi

git config --global user.name "${GIT_USER:-hexo}"
git config --global user.email "${GIT_EMAIL:-hexo@email.com}"

exec "$@"
