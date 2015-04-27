require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "Admin attributes must not be empty" do
  # test "the truth" do
  category = Category.new
  assert category.valid?
#  assert category.errors[:email].any?
  end
  end
