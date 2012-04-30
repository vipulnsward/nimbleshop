require "test_helper"

class ShippingMethodAcceptanceTest < ActionDispatch::IntegrationTest

  include ::CheckoutSpecHelper

  def sanitize(text)
    text.gsub(/\W/, ' ').gsub(/\s+/, ' ')
  end

  setup do
    Capybara.current_driver = :selenium
    create(:product, name: 'Bracelet Set', price: 25)
    create(:product, name: 'Necklace Set', price: 14)
    create(:country_shipping_method, name: 'Ground Shipping', base_price: 3.99, lower_price_limit: 1, upper_price_limit: 99999)
    create(:country_shipping_method, name: 'Express Shipping', base_price: 13.99, lower_price_limit: 1, upper_price_limit: 99999)
  end

  test "ability to change shipping method" do
    visit root_path
    add_item_to_cart('Bracelet Set')
    click_button 'Checkout'

    enter_valid_email_address
    enter_valid_shipping_address
    click_button 'Submit'

    choose 'Ground Shipping'
    click_button 'Submit'

    assert_equal 'Ground Shipping ( $3.99 )', find('.shipping-method').text
    click_link 'edit_shipping_method'

    choose 'Express Shipping'
    click_button 'Submit'

    assert_equal 'Express Shipping ( $13.99 )', find('.shipping-method').text
  end
end