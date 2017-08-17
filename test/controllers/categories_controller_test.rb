require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get categories modify path' do
    get categories_modify_path
    assert :success
  end

  test 'should create category' do
    get categories_modify_path
    post '/categories/modify', params: { category: { name: 'Test' } }
    assert_not_nil Category.find_by(name: 'Test')
  end

  test 'should delete category' do
    get categories_modify_path
    post '/categories/modify', params: { category: { name: 'Test' } }
    assert_not_nil Category.find_by(name: 'Test')
    delete '/categories/modify', params: { category: { name: 'Test' } }
    assert_nil Category.find_by(name: 'Test')
  end
end
