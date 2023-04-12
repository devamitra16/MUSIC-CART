ActiveAdmin.register Cart do

  
  actions :index, :show, :edit, :update
  permit_params do
    permitted = [:user_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
