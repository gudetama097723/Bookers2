require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new,index,show" do
    get books_new, index, show_url
    assert_response :success
  end
end
