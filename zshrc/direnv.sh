#!/usr/bin/env bash
eval "$(direnv hook zsh)" # Useful for shell.nix

# Direnv
# This cleans up the direnv output / nix shell starting environment variables
# stolen from user "alexreg" above in this issue
# https://github.com/direnv/direnv/issues/68#issuecomment-1003426550
copy_function() {
	test -n "$(declare -f "$1")" || return
	eval "${_/$1/$2}"
}

copy_function _direnv_hook _direnv_hook__old

_direnv_hook() {
	# old line
	#_direnv_hook__old "$@" 2> >(grep -E -v '^direnv: (export)')

	# my new line
	_direnv_hook__old "$@" 2> >(awk '{if (length >= 10) { sub("^direnv: export.*","direnv: export "NF" environment variables")}}1')

	# as suggested by user "radekh" above
	wait

	# as suggested by user "Ic-guy" below if you're using bash > v4.4
	# throws error for me on zsh
	# wait $!
}

nixify() {
	if [ ! -e ./.envrc ]; then
		echo "use nix" >.envrc
		direnv allow
	fi
	if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
		cat >default.nix <<'EOF'
with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [
    bashInteractive
  ];
}
EOF
		${EDITOR:-vim} default.nix
	fi
}

flakify() {
	if [ ! -e flake.nix ]; then
		nix flake new -t github:nix-community/nix-direnv .
	elif [ ! -e .envrc ]; then
		echo "use flake" >.envrc
		direnv allow
	fi
	${EDITOR:-vim} flake.nix
}
