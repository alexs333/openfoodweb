# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'


require 'spree/product_filters'
require 'open_food_web/searcher'

Spree.config do |config|
  config.site_name = "Open Food Web"
  config.logo = 'logo.jpg'
  config.admin_interface_logo = 'logo.jpg'

  config.shipping_instructions = true
  config.checkout_zone = 'Australia'
  config.address_requires_state = true
  config.default_country_id  = 12 # This should be Australia, see: spree/core/db/default/spree/countries.yml
  config.allow_guest_checkout = false

  config.searcher_class = OpenFoodWeb::Searcher

  # -- spree_paypal_express
  # Auto-capture payments. Without this option, payments must be manually captured in the paypal interface.
  config.auto_capture = true
end


# Add calculators category for enterprise fees
module Spree
  module Core
    class Environment
      class Calculators
        include EnvironmentExtension

        attr_accessor :enterprise_fees
      end
    end
  end
end
