Deface::Override.new(:virtual_path => "spree/products/show",
                     :name => "add_stock_email_to_products",
                     :insert_bottom => "[data-hook='cart_form']",
                     :partial => "spree/stock_emails/form",
                     :disabled => false)