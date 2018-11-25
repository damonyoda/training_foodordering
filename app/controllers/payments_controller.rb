class PaymentsController < ApplicationController
  skip_before_action :authenticate_admin
  before_action :set_order
  
  
  def new
    
  end

  def create
    flash[:notice]= "Payment success, food is on the way~~"
    session[:order_id] = nil
    @order.status = true
    @order.save
    redirect_to orderings_path
  end
  
  private 
  
  def set_order
    @order = Order.find(session[:order_id])
  end
  
end
