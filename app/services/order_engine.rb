class OrderEngine
    
    #OrderEngine.order(session[:order_id], session[:user_id], params[:menu_item_id], params[:quantity])
    def self.order(order_id, user_id, menu_item_id, quantity) 
    
        order = find_or_create_order(order_id, user_id)
        
        ordered_item = order.ordered_items.find_by(menu_item_id: menu_item_id)
        
        ordered_item = update_or_create_ordered_item(ordered_item, quantity, order, menu_item_id )
        
        
        return order.id, ordered_item.menu_item.name
    end 
    
    def self.find_or_create_order(order_id, user_id)
      if order_id.present?
          order = Order.find(order_id)
      else
          order = Order.new(user_id: user_id)
          order.save
      end
      order
    end
    
    def self.update_or_create_ordered_item(ordered_item, quantity, order, menu_item_id)
      if ordered_item.present?
          ordered_item.quantity += quantity.to_i
      else 
          ordered_item = order.ordered_items.new
          ordered_item.menu_item_id = menu_item_id
          ordered_item.quantity = quantity
      end
      ordered_item.save
      ordered_item
    end
    
    
end 