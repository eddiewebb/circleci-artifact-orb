#!/usr/bin/env bats

# load custom assertions and functions
load bats_helper


# setup is run beofre each test
function setup {
  INPUT_PROJECT_CONFIG=${BATS_TMPDIR}/input_config-${BATS_TEST_NUMBER}
  PROCESSED_PROJECT_CONFIG=${BATS_TMPDIR}/packed_config-${BATS_TEST_NUMBER} 
  JSON_PROJECT_CONFIG=${BATS_TMPDIR}/json_config-${BATS_TEST_NUMBER} 
	echo "#using temp file ${BATS_TMPDIR}/"

  # the name used in example config files.
  INLINE_ORB_NAME="artifacts"
}


@test "Command: full job expands properly" {
  # given
  process_config_with test/inputs/simple.yml

  # when
  assert_jq_match '.jobs | length' 1
  assert_jq_match '.jobs["build"].steps | length' 3

}









