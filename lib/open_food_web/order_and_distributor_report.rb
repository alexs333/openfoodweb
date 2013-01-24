
module OpenFoodWeb
  class OrderAndDistributorReport

    def initialize orders
      @orders = orders
    end

    def header
      ["Order date", "Order Id",
          "Customer Name","Customer Email", "Customer Phone", "Customer Address","Customer City",
          "Supplier", "Item name", "Variant", "Quantity", "Max Quantity", "Cost", "Shipping cost",
          "Payment method",
          "Distributor", "Distributor address", "Distributor city", "Distributor postcode", "Shipping instructions"]
    end

    def table
      order_and_distributor_details = []
      @orders.each do |order|
        order.line_items.each do |line_item|
<<<<<<< HEAD
          order_and_distributor_details << [order.completed_at, order.id,
            order.bill_address.full_name, order.email, order.bill_address.phone, order.bill_address.city,
            line_item.product.sku, line_item.product.name, line_item.variant.options_text, line_item.quantity, line_item.max_quantity, line_item.price * line_item.quantity, line_item.itemwise_shipping_cost,
=======
          order_and_distributor_details << [order.created_at, order.id,
            order.bill_address.full_name, order.email, order.bill_address.phone, order.bill_address.address1, order.bill_address.city,
            line_item.product.supplier.name, line_item.product.name, line_item.variant.options_text, line_item.quantity, line_item.max_quantity, line_item.price * line_item.quantity, line_item.itemwise_shipping_cost,
>>>>>>> 102cc09... changes to reports
            order.payments.first.payment_method.andand.name,
            order.distributor.andand.name, order.distributor.address.address1, order.distributor.address.city, order.distributor.address.zipcode, order.special_instructions ]
        end
      end
      order_and_distributor_details
    end
  end
end
