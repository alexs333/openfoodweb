Deface::Override.new(:virtual_path    => "spree/admin/orders/index",
                      :name           => "add_capture_order_shortcut2",
                      :insert_bottom => "[data-hook='admin_orders_index_rows'] .balance_due", 
                      :text           => '<h1>hey yo, your balance is due</h1>'
                      )
                      
