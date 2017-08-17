require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'test')
  end

  test 'should validate category' do
    assert @category.valid?
  end

  test 'should not validate duplicated category' do
    @copycat_category = @category
    @category.save
    refute @copycat_category.valid?
  end

  test 'should not validate empty category' do
    @category.name = ''
    refute @category.valid?
  end
end
