export MAVEN_HOME=/maven
export HOME=/workspace
export JAVA_HOME=/java

export PATH=${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${PATH}

# colors
LIGHT_GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
RED="$(tput setaf 1)"
WHITE="$(tput setaf 7)"
PURPLE="$(tput setaf 5)"
CYAN="$(tput setaf 6)"

PS1='\[${LIGHT_GREEN}\]\u@\[${RED}\]builder \[${WHITE}\]\W${PURPLE}${WHITE}]\$\[$NB\] '

