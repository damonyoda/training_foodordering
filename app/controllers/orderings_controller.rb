class OrderingsController < ApplicationController
  skip_before_action :authenticate_admin
  
  def index
    
    #@order = Order.find_by(customer_id: session[:customer_id], id: session[:order_id])
    # if @order.present?
    #   session[:order_id] = @order.id
    # else
    #   session[:order_id] = nil
    # end
    
    if session[:order_id].present?
      @order = Order.find_by(user_id: session[:user_id], status: false)
      if @order.present?
         session[:order_id] = @order.id
      else
         session[:order_id] = nil
      end
      # @order = Order.find(session[:order_id]) 
    end
    
    @categories = Category.order('id')
    # if params[:category_id].present?
    #   #@menu_items = MenuItem.where(category_id: params[:category_id])
    #   @menu_items = MenuItem.where(category_id: params[:category_id]).order(:position)
    # else
    #   @menu_items = MenuItem.joins(:category).order("categories.position, menu_items.position")
    # end
  end
  
  def order
    #this is class method
    #order_id, menu_item_name = OrderEngine.order(session[:order_id], session[:user_id], params[:menu_item_id], params[:quantity])
    
    #this is instance method
    order_machine = OrderMachine.new(session[:order_id], session[:user_id], params[:menu_item_id], params[:quantity])
    
    if order_machine.ordering
        session[:order_id] = order_machine.order.id
        flash[:notice] = "you have just ordered #{order_machine.menu_item.name}"
    else 
      flash[:alert] = "Please input a valid quantity"
    end
        redirect_to action: :index
        
    #order_id, menu_item_name = order_machine.order
    
    
    # if session[:order_id].present?
    #   order = Order.find(session[:order_id])
    # else
    #   order = Order.new(user_id: session[:user_id])
    #   order.save
    #   session[:order_id] = order.id
    # end
    
    # ordered_item = order.ordered_items.find_by(menu_item_id: params[:menu_item_id])
    
    # if ordered_item.present?
    #   ordered_item.quantity += params[:quantity].to_i
    # else 
    #   ordered_item = order.ordered_items.new
    #   ordered_item.menu_item_id = params[:menu_item_id]
    #   ordered_item.quantity = params[:quantity]
    # end
    # ordered_item.save
    
    # session[:order_id] = order_id
    # flash[:notice] = "you have just ordered #{menu_item_name}"
    
  end
  
  def checkout
    @order = Order.find( session[:order_id])
    if @order.ordered_items.blank?
      flash[:alert] = "Please order something"
      redirect_to orderings_path
    end
  end
  
  def update_order
    # params[:ordered_items] = { {"1": {"quantity":"2"}}, {"2":{"quantity":"3"} }
    params[:ordered_items].each do |ordered_item_id, quantity_params|
      ordered_item = OrderedItem.find(ordered_item_id)
      ordered_item.manage_quantity(nil, false, quantity_params[:quantity])
    #   ordered_item.quantity = quantity_params[:quantity]
    #   ordered_item.save
    end

    flash[:notice]= "Order updated"
    redirect_to checkout_orderings_path
  end
  
  def increase_quantity
    ordered_item = OrderedItem.find(params[:id])
    ordered_item.manage_quantity(true, true)
    # ordered_item.quantity += 1
    # ordered_item.save
    
    redirect_to checkout_orderings_path
  end
  
  def decrease_quantity
    ordered_item = OrderedItem.find(params[:id])
    ordered_item.manage_quantity(false, true)
    
    #   if ordered_item.quantity > 1
    #     ordered_item.quantity -= 1
    #     ordered_item.save
    #   else 
    #     ordered_item.destroy
    #   end
    
    redirect_to checkout_orderings_path
  end 
  
end
