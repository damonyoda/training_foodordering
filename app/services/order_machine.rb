class OrderMachine
    attr_reader :order_id, :user_id, :menu_item_id, :quantity, :menu_item
    attr_accessor :order
    
    #OrderMachine.new(session[:order_id], session[:user_id], params[:menu_item_id], params[:quantity])
    def initialize(order_id, user_id, menu_item_id, quantity)
        @order_id = order_id
        @user_id = user_id
        @menu_item_id = menu_item_id
        @quantity = quantity
        @menu_item = MenuItem.find( menu_item_id)
    end 
   
    def ordering
      
      if quantity.to_i > 0
        find_or_create_order
        update_or_create_ordered_item
        true
      else
        false
      end
        
    end
    
    def find_or_create_order
        user = User.find(@user_id)
        if order_id.present?
          self.order = user.orders.find(order_id)
        else
          @order = Order.new(user_id: user_id)
          @order.save
          self.order = @order 
        end
    end 
    
    
    def update_or_create_ordered_item
        @ordered_item = @order.ordered_items.find_by(menu_item_id: menu_item_id)
        if @ordered_item.present?
          @ordered_item.quantity += quantity.to_i
        else 
          @ordered_item = @order.ordered_items.new
          @ordered_item.menu_item_id = menu_item_id
          @ordered_item.quantity = quantity
        end
        @ordered_item.save
        @ordered_item
    end
       


end