require 'test_helper'

class CustomerProvincesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_provinces_index_url
    assert_response :success
  end

end
