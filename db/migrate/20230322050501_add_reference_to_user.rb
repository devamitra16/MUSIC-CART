class AddReferenceToUser < ActiveRecord::Migration[6.0]
  def change
    
    add_reference :users, :accountable, polymorphic: true
  end
end
