require "application_system_test_case"

class OrderedItemsTest < ApplicationSystemTestCase
  setup do
    @ordered_item = ordered_items(:one)
  end

  test "visiting the index" do
    visit ordered_items_url
    assert_selector "h1", text: "Ordered Items"
  end

  test "creating a Ordered item" do
    visit ordered_items_url
    click_on "New Ordered Item"

    fill_in "Instrument", with: @ordered_item.instrument_id
    fill_in "Order", with: @ordered_item.order_id
    click_on "Create Ordered item"

    assert_text "Ordered item was successfully created"
    click_on "Back"
  end

  test "updating a Ordered item" do
    visit ordered_items_url
    click_on "Edit", match: :first

    fill_in "Instrument", with: @ordered_item.instrument_id
    fill_in "Order", with: @ordered_item.order_id
    click_on "Update Ordered item"

    assert_text "Ordered item was successfully updated"
    click_on "Back"
  end

  test "destroying a Ordered item" do
    visit ordered_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ordered item was successfully destroyed"
  end
end
