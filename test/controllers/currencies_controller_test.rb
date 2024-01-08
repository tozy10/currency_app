require "test_helper"

class CurrenciesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get currencies_index_url
    assert_response :success
  end

  test "should get edit" do
    get currencies_edit_url
    assert_response :success
  end

  test "should get new" do
    get currencies_new_url
    assert_response :success
  end
end
