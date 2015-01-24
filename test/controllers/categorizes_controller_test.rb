require 'test_helper'

class CategorizesControllerTest < ActionController::TestCase
  setup do
    @categorize = categorizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categorize" do
    assert_difference('Categorize.count') do
      post :create, categorize: {  }
    end

    assert_redirected_to categorize_path(assigns(:categorize))
  end

  test "should show categorize" do
    get :show, id: @categorize
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categorize
    assert_response :success
  end

  test "should update categorize" do
    patch :update, id: @categorize, categorize: {  }
    assert_redirected_to categorize_path(assigns(:categorize))
  end

  test "should destroy categorize" do
    assert_difference('Categorize.count', -1) do
      delete :destroy, id: @categorize
    end

    assert_redirected_to categorizes_path
  end
end
