Deface::Override.new(:virtual_path    => "spree/admin/orders/index",
                      :name           => "add_capture_order_shortcut",
                      :insert_after  => "[data-hook='admin_orders_index_rows'] td:nth-child(4) .state", #how can I hook into each row?..
                      #copied from backend / app / views / spree / admin / payments / _list.html.erb:
                      :text           => '<% order.payment.actions.grep(/^capture$/).each do |action| %>
                                            <%= link_to_with_icon "icon-#{action}", t(action), fire_admin_order_payment_path(order, order.payment, :e => action), :method => :put, :no_text => true, :data => {:action => action} %>
                                          <% end %>'
                      )
                      
