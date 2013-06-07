require 'spec_helper'

feature "enterprises distributor info as rich text" do
  include AuthenticationWorkflow
  include WebHelper

  before(:each) do
    ENV['OFW_DEPLOYMENT'] = 'local_organics'

    # The deployment is not set to local_organics on Rails init, so these
    # initializers won't run. Re-call them now that the deployment is set.
    EnterprisesDistributorInfoRichTextFeature::Engine.initializers.each &:run
  end


  scenario "setting distributor info as admin" do
    # Given I'm signed in as an admin
    login_to_admin_section

    # When I go to create a new enterprise
    click_link 'Enterprises'
    click_link 'New Enterprise'

    # Then I should see fields 'Profile Info' and 'Distributor Info'
    page.should have_selector 'td', text: 'Profile Info:'
    page.should have_selector 'td', text: 'Distributor Info:'

    # When I fill out the form and create the enterprise
    fill_in 'enterprise_name', :with => 'Eaterprises'
    fill_in 'enterprise_long_description', with: 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro.'
    fill_in 'enterprise_distributor_info', with: 'Chu ge sai yubi dan bisento tobi ashi yubi ge omote.'
    fill_in 'enterprise_address_attributes_address1', with: '35 Ballantyne St'
    fill_in 'enterprise_address_attributes_city', with: 'Thornbury'
    fill_in 'enterprise_address_attributes_zipcode', with: '3072'
    select 'Australia', from: 'enterprise_address_attributes_country_id'
    select 'Victoria', from: 'enterprise_address_attributes_state_id'

    click_button 'Create'

    # Then I should see the enterprise details
    flash_message.should == 'Enterprise "Eaterprises" has been successfully created!'
    click_link 'Eaterprises'
    page.should have_selector "tr[data-hook='long_description'] th", text: 'Profile Info:'
    page.should have_selector "tr[data-hook='long_description'] td", text: 'Zombie ipsum reversus ab viral inferno, nam rick grimes malum cerebro.'

    page.should have_selector "tr[data-hook='distributor_info'] th", text: 'Distributor Info:'
    page.should have_selector "tr[data-hook='distributor_info'] td", text: 'Chu ge sai yubi dan bisento tobi ashi yubi ge omote.'
  end

  scenario "viewing distributor info", js: true do
    setup_shipping_details

    d = create(:distributor_enterprise, distributor_info: 'Chu ge sai yubi dan <strong>bisento</strong> tobi ashi yubi ge omote.', next_collection_at: 'Thursday 2nd May')
    p = create(:product, :distributors => [d])

    login_to_consumer_section
    visit spree.select_distributor_order_path(d)

    # -- Product details page
    visit spree.product_path p
    within '#product-distributor-details' do
      page.should have_content 'Chu ge sai yubi dan bisento tobi ashi yubi ge omote.'
      page.should have_content 'Thursday 2nd May'
    end

    # -- Checkout
    click_button 'Add To Cart'
    click_link 'Checkout'
    within 'fieldset#shipping' do
      page.should have_content 'Chu ge sai yubi dan bisento tobi ashi yubi ge omote.'
      page.should have_content 'Thursday 2nd May'
    end

    # -- Purchase email
    complete_purchase_from_checkout_address_page
    sleep 2 # The default timeout for wait_until is not always enough here
    wait_until { ActionMailer::Base.deliveries.length == 1 }
    ActionMailer::Base.deliveries.length.should == 1
    email = ActionMailer::Base.deliveries.last
    email.body.should =~ /Chu ge sai yubi dan bisento tobi ashi yubi ge omote./
    email.body.should =~ /Thursday 2nd May/
  end


  private
  def setup_shipping_details
    zone = create(:zone)
    c = Spree::Country.find_by_name('Australia')
    Spree::ZoneMember.create(:zoneable => c, :zone => zone)
    create(:itemwise_shipping_method, zone: zone)
    create(:payment_method, :description => 'Cheque payment method')
  end


  def complete_purchase_from_checkout_address_page
    fill_in_fields('order_bill_address_attributes_firstname' => 'Joe',
                   'order_bill_address_attributes_lastname' => 'Luck',
                   'order_bill_address_attributes_address1' => '19 Sycamore Lane',
                   'order_bill_address_attributes_city' => 'Horse Hill',
                   'order_bill_address_attributes_zipcode' => '3213',
                   'order_bill_address_attributes_phone' => '12999911111')

    select('Australia', :from => 'order_bill_address_attributes_country_id')
    select('Victoria', :from => 'order_bill_address_attributes_state_id')

    click_button 'Save and Continue'
    click_button 'Save and Continue'
    click_button 'Process My Order'
  end
end