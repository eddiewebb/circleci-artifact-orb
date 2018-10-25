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
  INLINE_ORB_NAME="banners"
}


@test "Command: single" {
  # given
  process_config_with test/inputs/simple.yml

  # when
  assert_jq_match '.jobs | length' 1
  assert_jq_match '.jobs["build"].steps | length' 1
  assert_jq_match '.jobs["build"].steps[0].run.name ' "Print Banner"

}


@test "Command: many calls" {
  # given
  process_config_with test/inputs/many.yml

  # when
  assert_jq_match '.jobs | length' 1
  assert_jq_match '.jobs["build"].steps | length' 3
  assert_jq_match '.jobs["build"].steps[0].run.name ' "Print Banner"

}


@test "Command: figlet works (slow, local build)" {
  # given
  process_config_with test/inputs/simple.yml

  # when
  cp ${PROCESSED_PROJECT_CONFIG} local.yml
  run circleci build -c local.yml
  rm local.yml

  START=$( expr ${#lines[@]} - 7 )
  >${BATS_TMPDIR}/output
  for line in "${lines[@]:$START:7}"; do
    echo "$line" >> ${BATS_TMPDIR}/output
  done
  output=`cat ${BATS_TMPDIR}/output`

  assert_matches_file test/outputs/starting_build

}









