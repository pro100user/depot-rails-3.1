# -*- encoding : utf-8 -*-
require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
      @update = {
        title: 'Lorem ipsum',
        description: 'Dolor sit',
        image_url: 'lorm.jpg',
        price: 19.90
      }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product.to_param
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product.to_param, product: @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product.to_param
    end

    assert_redirected_to products_path
  end

  test "should be three admin links" do
    get :index
    assert_select 'td.list_actions' do |elements|
      elements.each do |element|
        assert_select element, "a", 3
      end
    end
  end

end
