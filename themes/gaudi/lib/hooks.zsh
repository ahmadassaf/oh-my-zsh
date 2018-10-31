#!/usr/bin/env zsh

GAUDI_HOOKS=(
    elapsed       # Last command runtime
)

if [[ -n "${GAUDI_HOOKS}" ]]; then
for hook in ${GAUDI_HOOKS[@]}; do
    source "$GAUDI_ROOT/lib/hooks/$hook.zsh"
    gaudi_$hook
done
fi;