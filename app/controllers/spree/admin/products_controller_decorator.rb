Spree::Admin::ProductsController.class_eval do

    before_filter :set_current_on_hand_value, only: :update
    after_filter  :send_stock_emails, only: :update    
    
    
    def set_current_on_hand_value
      @had_no_stock = !@product.has_stock?
    end

    def send_stock_emails      
      Spree::StockEmail.notify(@product) if @had_no_stock && @product.has_stock?
    end

    
    def collection
      return @collection if @collection.present?

      unless request.xhr?
        params[:q] ||= {}
        params[:q][:deleted_at_null] ||= "1"

        params[:q][:s] ||= "name asc"

        @search = super.ransack(params[:q])
        @collection = @search.result.
          group_by_products_id.
          includes([:master, {:variants => [:images, :option_values]}]).
          page(params[:page]).
          per(Spree::Config[:admin_products_per_page])

          # PostgreSQL compatibility
          if params[:q][:s].include?("master_price")
            @collection = @collection.group("spree_variants.price")
          end
          
          # ----- Stock Emails -----
          if params[:q][:s].include?("stock_emails_size")
            @collection = @collection.includes(:stock_emails).
                              select("spree_products.*, COUNT(spree_stock_emails.id) AS stock_emails_size").
                              where("spree_stock_emails.sent_at IS NULL").
                              order(params[:q][:s])
          end
          
          
      else
        includes = [{:variants => [:images,  {:option_values => :option_type}]}, {:master => :images}]

        @collection = super.where(["name #{LIKE} ?", "%#{params[:q]}%"])
        @collection = @collection.includes(includes).limit(params[:limit] || 10)

        tmp = super.where(["#{Variant.table_name}.sku #{LIKE} ?", "%#{params[:q]}%"])
        tmp = tmp.includes(:variants_including_master).limit(params[:limit] || 10)
        @collection.concat(tmp)
      end
      @collection
    end
end
