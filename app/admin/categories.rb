ActiveAdmin.register Category, as: "Category" do

	permit_params [:name, :description, :picture]

	remove_filter :picture_attachment, :picture_blob

	index do
    selectable_column
    id_column
    column :picture do |img|
    	# debugger
    end
    column :name
    column :description
    column :created_at
    actions
  end

  form do |f|
  	f.input :name 
  	f.input :description
  	f.input :picture, as: :file
  	f.actions 
  end
end