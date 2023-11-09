require "application_system_test_case"

class HelloTest < ApplicationSystemTestCase
   test "visiting the index" do
     visit '/hello/world'
  #
     assert_selector "h1", text: "Counter"
   end
end
