ActiveAdmin.register Cart do

  
  actions :index, :show
  permit_params do
    permitted = [:user_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  show do
  attributes_table do
    row :id
  end

  panel "Instruments" do
    table_for resource.line_items do
      column :id
      column "Instrument Name" do |line_item|
        line_item.instrument.title
      end
      column "Instrument Model" do |line_item|
        line_item.instrument.model
      end
      column "Instrument Condition" do |line_item|
        line_item.instrument.condition
      end
      column :quantity
    end
  end
end
  
end
