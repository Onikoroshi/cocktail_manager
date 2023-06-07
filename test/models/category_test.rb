require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "requires name presence" do
    category = Category.create
    assert category.invalid?
    assert category.errors.added? :name, "can't be blank"

    category = Category.create(name: "Test Category")
    assert category.valid?
    assert category.errors.empty?
  end

  test "stores the name as all downcase" do
    category = Category.create(name: "Test caTegorY")
    assert_equal category.name, "test category"
  end

  test "displays name in a nice capital way" do
    category = Category.create(name: "test category")
    assert_equal category.to_s, "Test Category"

    category = Category.create(name: "test CaTegory")
    assert_equal category.to_s, "Test Category"
  end
end
