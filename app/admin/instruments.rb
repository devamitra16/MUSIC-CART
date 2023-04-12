ActiveAdmin.register Instrument do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :brand, :model, :description, :condition, :color, :title, :price, :image, :user_id, :quantity
  #
  # or
  #
  filter :title
  filter :brand
  filter :model
  

  permit_params do
    permitted = [:brand, :model, :description, :condition, :color, :title, :price, :image, :user_id, :quantity]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
