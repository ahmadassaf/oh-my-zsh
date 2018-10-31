function cfap() { cf app $1 }
function cfh.() { export CF_HOME=$PWD/.cf }
function cfh~() { export CF_HOME=~/.cf }
function cfhu() { unset CF_HOME }
function cfpm() { cf push -f $1 }
function cflr() { cf logs $1 --recent }
function cfsrt() { cf start $1 }
function cfstp() { cf stop $1 }
function cfstg() { cf restage $1 }
function cfdel() { cf delete $1 }
function cfsrtall() {cf apps | awk '/stopped/ { system("cf start " $1)}'}
function cfstpall() {cf apps | awk '/started/ { system("cf stop " $1)}'}
