Deface::Override.new(:virtual_path => "spree/admin/products/index",
                     :name => "add_stock_email_to_list_of_products_td",
                     :insert_before => "[data-hook='admin_products_index_row_actions']",
                     :text => "<td><%= Spree::StockEmail.where(sent_at: nil, product_id: product.id).size %> <%= t('spree.stock_email.of') %> <%= Spree::StockEmail.where(product_id: product.id).size %></td>",
                     :disabled => false)
                     
Deface::Override.new(:virtual_path => "spree/admin/products/index",
                     :name => "add_stock_email_to_list_of_products_th",
                     :insert_before => "[data-hook='admin_products_index_header_actions']",
                     :text => "<th><%= sort_link @search,'stock_emails_size', t('spree.stock_email.admin_header') %></th>",
                     :disabled => false)