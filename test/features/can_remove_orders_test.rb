require "./test/test_helper"

class CanRemoveOrdersTest < Capybara::Rails::TestCase

  test "user can delete orders" do
    restaurant = FactoryGirl.create(:restaurant)
    item = restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')

    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on "Add to Order"
    end

    visit cart_path

    within("#item_1") do
      click_on "remove_item"
    end

    assert_content page, "Your Order is empty."
  end

  test "orders error when quantity is zero" do
    restaurant = FactoryGirl.create(:restaurant)
    item = restaurant.items.create(title: 'Deviled Eggs', description: '12 luscious eggs', price: '1')

    visit restaurant_path(restaurant)

    within("#item_1") do
      click_on "Add to Order"
    end

    visit cart_path

    within("#item_1") do
      fill_in "order_item_quantity", with: 0
      click_on "Update Quantity"
    end

    assert_content page, "There was an error"

  end
end
