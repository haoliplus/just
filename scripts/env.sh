

INSTALL="apt install"
if [[ ${UID} -ne 0 ]]; then
  CMD="sudo "${INSTALL}
fi
