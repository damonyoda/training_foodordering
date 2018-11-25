class ApplicationController < ActionController::Base
    before_action :authenticate_user, :authenticate_admin
    
    
    helper_method :is_admin?
    
    
    def is_admin?
        user = User.find(session[:user_id])
        user.is_admin?
    end
    
    def authenticate_admin
        if is_admin?
            
        else
            redirect_to menu_items_path
            flash[:alert] = "UNAUTHORISED ACCESS"
        end
    end
        
        
    
    def authenticate_user
        if session[:user_id].present?
            
        elsif 
            redirect_to login_path
        end
    end
    

        
end
