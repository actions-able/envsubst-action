#!/bin/sh

# https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425?permalink_comment_id=3945021
#set -eo pipefail

DEBUG=true
WORKING_DIRECTORY=$1
INPUT_FILE=$2
OUTPUT_FILE=$3
INPUT_FILE_PATTERN=$4
OUTPUT_FILE_SUFFIX=$5

verbose() {
  if [ "${DEBUG}" = true ]; then
    echo "${1}"
  fi
}

validate_inputs() {
  if [ -z "${WORKING_DIRECTORY}" ]; then
    echo "ERROR: You must define your 'working-directory'" 1>&2
    exit 1
  fi

  if [ -z "${INPUT_FILE}" ] && [ -z "${INPUT_FILE_PATTERN}" ]; then
    echo "ERROR: You must define one of 'input-file' or 'input-file-pattern' to use this utility" 1>&2
    exit 1
  fi
  if [ -n "${INPUT_FILE}" ] && [ -z "${OUTPUT_FILE}" ]; then
    echo "ERROR: You must define 'output-file' input when using 'input-file'" 1>&2
    exit 1
  fi
  if [ -n "${INPUT_FILE_PATTERN}" ] && [ -z "${OUTPUT_FILE_SUFFIX}" ]; then
    echo "ERROR: You must define 'output-file-suffix' input when using 'input-file-pattern'" 1>&2
    exit 1
  fi
}

verbose "DEBUG=${DEBUG}"
verbose "WORKING_DIRECTORY=${WORKING_DIRECTORY}"
verbose "INPUT_FILE=${INPUT_FILE}"
verbose "OUTPUT_FILE=${OUTPUT_FILE}"
verbose "INPUT_FILE_PATTERN=${INPUT_FILE_PATTERN}"
verbose "OUTPUT_FILE_SUFFIX=${OUTPUT_FILE_SUFFIX}"

validate_inputs

# Exec envsubst
if [ -n "${INPUT_FILE}" ] && [ -n "${OUTPUT_FILE}" ]; then
  if [ ! -f "${WORKING_DIRECTORY}/${INPUT_FILE}" ]; then
    echo "ERROR: ${WORKING_DIRECTORY}/${INPUT_FILE} file not found." 1>&2
    exit 1
  fi
  verbose "Applying envsubst with file ${WORKING_DIRECTORY}/${INPUT_FILE}"
  envsubst <"${WORKING_DIRECTORY}/${INPUT_FILE}" >"${WORKING_DIRECTORY}/${OUTPUT_FILE}"
  exit 0
fi
if [ -n "${INPUT_FILE_PATTERN}" ] && [ -n "${OUTPUT_FILE_SUFFIX}" ]; then
  verbose "Applying envsubst with pattern ${INPUT_FILE_PATTERN}"
  find "${WORKING_DIRECTORY}" -name "${INPUT_FILE_PATTERN}" -type f -exec sh -c 'envsubst < "${1}" > "${1}${2}"' shell '{}' "${OUTPUT_FILE_SUFFIX}" \;
  exit 0
fi
