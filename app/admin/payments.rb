ActiveAdmin.register Payment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :card_number, :expiry_month, :expiry_year, :name_on_the_card, :pay_amount, :user_id, :order_id, :cvv
  #
  # or
  #
  actions :index, :show
  permit_params do
    permitted = [:card_number, :expiry_month, :expiry_year, :name_on_the_card, :pay_amount, :user_id, :order_id, :cvv]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
