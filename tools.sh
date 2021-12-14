# log
info() {
  printf "%s - [INFO] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >&2
}

error() {
  printf "%s - [ERROR] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >&2
}

quit() {
  echo "$1"
  exit "$2"
}

os_type() {
    local os='unkown'
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        os='linux'
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        os='darwin'
    fi

    echo ${os}
}

get_cpu_num() {
    os="$(os_type)"
    if [[ "$os" == "darwin" ]]; then
        echo "$(sysctl hw.logicalcpu | cut -d ' ' -f2)"
    elif [[ "$os" == "linux" ]]; then 
        echo "$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')"
    else
        echo "unsupport os type $os"
    fi
}
