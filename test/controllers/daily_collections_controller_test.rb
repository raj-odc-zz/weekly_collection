require 'test_helper'

class DailyCollectionsControllerTest < ActionController::TestCase
  setup do
    @daily_collection = daily_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_collection" do
    assert_difference('DailyCollection.count') do
      post :create, daily_collection: { amount: @daily_collection.amount, loan_id: @daily_collection.loan_id, user_id: @daily_collection.user_id }
    end

    assert_redirected_to daily_collection_path(assigns(:daily_collection))
  end

  test "should show daily_collection" do
    get :show, id: @daily_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_collection
    assert_response :success
  end

  test "should update daily_collection" do
    patch :update, id: @daily_collection, daily_collection: { amount: @daily_collection.amount, loan_id: @daily_collection.loan_id, user_id: @daily_collection.user_id }
    assert_redirected_to daily_collection_path(assigns(:daily_collection))
  end

  test "should destroy daily_collection" do
    assert_difference('DailyCollection.count', -1) do
      delete :destroy, id: @daily_collection
    end

    assert_redirected_to daily_collections_path
  end
end
