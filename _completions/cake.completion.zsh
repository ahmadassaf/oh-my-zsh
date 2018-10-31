_cake () {
	if [ -f Cakefile ]; then
		if _cake_does_target_list_need_generating; then
			_cake_get_target_list > ${_cake_task_cache_file}
			compadd `cat ${_cake_task_cache_file}`
		else
			compadd `_cake_get_target_list`
		fi
	fi
}

compdef _cake cake
