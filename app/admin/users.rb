ActiveAdmin.register User, as: "Users" do 
	actions :show, :index

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :activated
    column :created_at
    actions
  end

  filter :name 
  filter :email 
  filter :activated

  show do |user|
  	attributes_table do
			row :name
			row :email
			row :activated
			row :created_at
			row :updated_at
  	end
  end
end