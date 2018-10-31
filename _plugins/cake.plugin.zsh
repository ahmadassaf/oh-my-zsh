# Set this to 1 if you want to cache the tasks
_cake_cache_task_list=1

# Cache filename
_cake_task_cache_file='.cake_task_cache'

_cake_get_target_list () {
	cake | grep '^cake ' | sed -e "s/cake \([^ ]*\) .*/\1/" | grep -v '^$'
}

_cake_does_target_list_need_generating () {

	if [ ${_cake_cache_task_list} -eq 0 ]; then
		return 1;
	fi

	[ ! -f ${_cake_task_cache_file} ] && return 0;
	[ Cakefile -nt ${_cake_task_cache_file} ] && return 0;
	return 1;
}