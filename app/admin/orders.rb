ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :address, :contact_number, :user_id
  #
  # or
  #
  actions :index, :show
  permit_params do
    permitted = [:address, :contact_number, :user_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
