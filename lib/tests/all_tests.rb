ignore = [".", "..", "tests", "all_tests.rb", "test.rb"]

Dir.foreach("lib/tests") do |test|
  if not(ignore.include?(test))
    str_require = test.slice(0, test.index('.'))
    require_relative str_require
  end
end
