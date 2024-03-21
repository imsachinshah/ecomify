ActiveAdmin.register Category, as: "Category" do

	permit_params [:name, :description, :picture]

	remove_filter :picture_attachment, :picture_blob

	index do
    selectable_column
    id_column
    column :picture do |object|
    	image_tag url_for(object.picture), width:100,height:80
    end
    column :name
    column :description
    column :created_at
    actions
  end

  show do
  	attributes_table do
			row :name
			row :description
			row :picture do |object|
	    	image_tag url_for(object.picture), width:100,height:80
	    end
			row :created_at
			row :updated_at
  	end
  end

  form do |f|
  	f.semantic_errors
  	f.input :name 
  	f.input :description
  	f.input :picture, as: :file
  	f.actions 
  end
end