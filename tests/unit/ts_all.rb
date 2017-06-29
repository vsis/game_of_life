require "test/unit/testsuite"

test_cases = [
    "tc_gmap",
    "tc_gmap_reader",
]

test_cases.each do |test_case|
    require_relative test_case
end
