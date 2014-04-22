#!/bin/sh
# file: test_bootstrap.sh

test_install_tool_return_bad_args_code_when_wrong_number_of_parameters()
{
  # colors = \033[31m <-- RED,
  local RESULTS
  RESULTS=$(_install_tool)
  assertEquals "It must return invalid number of parameters code!" "65" "$?"
  assertEquals "Usage message must be showed!" \
               "USAGE: _install_tool tool_name cmd_check_installed install_cmd" \
               "${RESULTS}"
  RESULTS=$(_install_tool 1st_param 2nd_param)
  assertEquals "It must return invalid number of parameters code!" "65" "$?"
  RESULTS=$(_install_tool 1st_param 2nd_param 3rd_param 4th_param)
  assertEquals "It must return invalid number of parameters code!" "65" "$?"
}

test_install_tool_return_success_code_if_tool_already_installed()
{
  local RESULTS
  local cmd_name="sh"
  RESULTS=$(_install_tool ${cmd_name} "test -e /bin/${cmd_name}" "dummy cmd")
  assertEquals "It must return success code!" "0" "$?"
  assertEquals "Already installed message must be showed!" \
               "${cmd_name} already installed!" \
               "${RESULTS}"
}

test_install_tool_will_execute_install_cmd_when_tool_not_installed()
{
  local RESULTS
  local cmd_name="dummy_cmd"
  RESULTS=$(_install_tool ${cmd_name} "test -e /bin/${cmd_name}" "false")
  assertEquals "It must return false status code (I passed false...)" \
               "1" "$?"
  assertEquals "Installing message must be showed!" \
               "Installing ${cmd_name}..." \
               "${RESULTS}"
}


oneTimeSetUp()
{
  # load include to test
  . ./bootstrap.sh test
}

# load shunit2
SHUNIT_PARENT=$0
. shunit2
