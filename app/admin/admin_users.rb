ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation
  actions :index, :show
  #actions :show, :edit if proc{current_admin_user.email == resource.email}
  #action :edit if: proc{current_admin_user.email == resource.email}
  index do
    selectable_column
    id_column
    column :email
    
    column :created_at
actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

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
