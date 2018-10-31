gradle-or-gradlew() {
	if [ -f ./gradlew ] ; then
		echo "executing gradlew instead of gradle";
		./gradlew "$@";
	else
		gradle "$@";
	fi
}

alias gradle=gradle-or-gradlew;