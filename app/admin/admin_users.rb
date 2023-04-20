ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation
  #actions :index
  #config.clear_action_items!
  index do
    selectable_column
    id_column
    column :email
    
    column :created_at

    actions defaults: false do |admin_user|
    item "Edit", edit_admin_admin_user_path(admin_user) if current_admin_user.email == admin_user.email
    text_node "&nbsp".html_safe
    text_node "&nbsp".html_safe
    text_node "&nbsp".html_safe
    item "View", admin_admin_user_path(admin_user)
    text_node "&nbsp".html_safe
    text_node "&nbsp".html_safe
    text_node "&nbsp".html_safe
    # item "Delete", admin_admin_user_path(admin_user),method: :delete if current_admin_user.email == admin_user.email


    end

  end


  show do
  attributes_table do
    row :id
  end

  panel "Admin users" do
    table_for resource do
      column :id
      column :email
      column :created_at
    end
  end
  
  end

 

    

  filter :email
  filter :current_sign_in_at
 

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # action_item(:edit_user,only: :show) do
  #   link_to edit_admin_admin_user_path(resource)
  # end

  # member_action(:edit_user,method: :get) do

  # end

  # controller do
  #   def action_method_names
  #     if current_admin_user.email == resource.email
  #       [:edit]
  #     else
  #       []
  #     end
  #   end 
  # end


end
