require "test_helper"

class EmailOtpsControllerTest < ActionDispatch::IntegrationTest
  test "should get verify_account" do
    get email_otps_verify_account_url
    assert_response :success
  end
end
