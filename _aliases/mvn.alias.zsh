# mvn-color based on https://gist.github.com/1027800
BOLD=$(tput bold)
UNDERLINE_ON=$(tput smul)
UNDERLINE_OFF=$(tput rmul)
TEXT_BLACK=$(tput setaf 0)
TEXT_RED=$(tput setaf 1)
TEXT_GREEN=$(tput setaf 2)
TEXT_YELLOW=$(tput setaf 3)
TEXT_BLUE=$(tput setaf 4)
TEXT_MAGENTA=$(tput setaf 5)
TEXT_CYAN=$(tput setaf 6)
TEXT_WHITE=$(tput setaf 7)
BACKGROUND_BLACK=$(tput setab 0)
BACKGROUND_RED=$(tput setab 1)
BACKGROUND_GREEN=$(tput setab 2)
BACKGROUND_YELLOW=$(tput setab 3)
BACKGROUND_BLUE=$(tput setab 4)
BACKGROUND_MAGENTA=$(tput setab 5)
BACKGROUND_CYAN=$(tput setab 6)
BACKGROUND_WHITE=$(tput setab 7)
RESET_FORMATTING=$(tput sgr0)

# if found an executable ./mvnw file execute it otherwise execute orignal mvn
mvn-or-mvnw() {
	if [ -x ./mvnw ] ; then
		echo "executing mvnw instead of mvn"		
		./mvnw "$@";
	else
		mvn "$@";
	fi
}

# Wrapper function for Maven's mvn command.
mvn-color() {
  (
  # Filter mvn output using sed. Before filtering set the locale to C, so invalid characters won't break some sed implementations
  unset LANG
  LC_CTYPE=C mvn "$@" | sed -e "s/\(\[INFO\]\)\(.*\)/${TEXT_BLUE}${BOLD}\1${RESET_FORMATTING}\2/g" \
               -e "s/\(\[INFO\]\ BUILD SUCCESSFUL\)/${BOLD}${TEXT_GREEN}\1${RESET_FORMATTING}/g" \
               -e "s/\(\[WARNING\]\)\(.*\)/${BOLD}${TEXT_YELLOW}\1${RESET_FORMATTING}\2/g" \
               -e "s/\(\[ERROR\]\)\(.*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}\2/g" \
               -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"
 
  # Make sure formatting is reset
  echo -ne "${RESET_FORMATTING}"
    )
}

# Override the mvn command with the colorized one.
#alias mvn="mvn-color"

# either use orignal mvn oder the mvn wrapper
alias mvn="mvn-or-mvnw"

# aliases
alias mvncie='mvn clean install eclipse:eclipse'
alias mvnci='mvn clean install'
alias mvncist='mvn clean install -DskipTests'
alias mvncisto='mvn clean install -DskipTests --offline'
alias mvne='mvn eclipse:eclipse'
alias mvnce='mvn clean eclipse:clean eclipse:eclipse'
alias mvncv='mvn clean verify'
alias mvnd='mvn deploy'
alias mvnp='mvn package'
alias mvnc='mvn clean'
alias mvncom='mvn compile'
alias mvnct='mvn clean test'
alias mvnt='mvn test'
alias mvnag='mvn archetype:generate'
alias mvn-updates='mvn versions:display-dependency-updates'
alias mvntc7='mvn tomcat7:run' 
alias mvntc='mvn tomcat:run'
alias mvnjetty='mvn jetty:run'
alias mvnboot='mvn spring-boot:run'
alias mvndt='mvn dependency:tree'
alias mvns='mvn site'
alias mvnsrc='mvn dependency:sources'
alias mvndocs='mvn dependency:resolve -Dclassifier=javadoc'