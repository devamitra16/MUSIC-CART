ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :acc_id, :accountable_type, :accountable_id
  #
  # or
  #
  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :updated_at
    column :name
    column :accountable_type
    column :accountable_id
    actions

  end
  
  filter :name
  scope :customer
  scope :seller

  permit_params do
    permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :acc_id, :accountable_type, :accountable_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
