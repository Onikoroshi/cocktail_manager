require "test_helper"

class ContainerTest < ActiveSupport::TestCase
  test "requires name presence" do
    container = Container.create
    assert container.invalid?
    assert container.errors.added? :name, "can't be blank"

    container = Container.create(name: "Test Container")
    assert container.valid?
    assert container.errors.empty?
  end

  test "stores the name as all downcase" do
    container = Container.create(name: "Test conTaineR")
    assert_equal container.name, "test container"
  end

  test "displays name in a nice capital way" do
    container = Container.create(name: "test container")
    assert_equal container.to_s, "Test Container"

    container = Container.create(name: "test ConTainer")
    assert_equal container.to_s, "Test Container"
  end
end
