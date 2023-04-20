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
  actions :index, :show, :edit, :update
  permit_params do
    permitted = [:address, :contact_number,:order_status,:user_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  show do
  attributes_table do
    row :id
  end

  panel "Instruments" do
    table_for resource.ordered_items do
      column :id
      column "Ordered Item Name" do |ordered_item|
        ordered_item.instrument.title
      end
       column "Ordered Item description" do |ordered_item|
        ordered_item.instrument.description
      end
      column "Ordered Item Condition" do |ordered_item|
        ordered_item.instrument.condition
      end
      column "Ordered Item Model" do |ordered_item|
        ordered_item.instrument.model
      end
      column :quantity
    end
  end

  end
  
end
  

