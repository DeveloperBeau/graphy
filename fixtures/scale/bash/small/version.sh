# Version metadata for textprint.

TEXTPRINT_VERSION="1.4.2"

textprint_version() {
  echo "$TEXTPRINT_VERSION"
}

textprint_build_info() {
  echo "textprint $TEXTPRINT_VERSION on bash ${BASH_VERSION%%.*}"
}
