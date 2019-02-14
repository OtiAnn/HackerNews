require 'test_helper'

class MagazineControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get magazine_index_url
    assert_response :success
  end

end
