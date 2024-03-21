ActiveAdmin.register Product, as: "Product" do
	permit_params [:name, :description, :color, :price, :category_id, images: []]

	filter :name

	index do
    selectable_column
    id_column
    column :picture do |object|
    	image_tag url_for(object.images.first), width:100,height:80
    end
    column :name
    column :category_id do |object|
    	object.category.name
    end
    column :created_at
    actions
  end

  show do
  	attributes_table do
			row :name
			row :description
			row :picture do |object|
		    image_tag url_for(object.images.first), width:100,height:80
		  end
		  row :category_id do |object|
	    	object.category.name
	    end
			row :created_at
			row :updated_at
  	end
  end

  form do |f|
  	f.semantic_errors
  	f.input :category_id, as: :select, collection: Category.all.map { |c| [c.name, c.id] }, include_blank: false
  	f.input :name
  	f.input :description, as: :quill_editor
  	f.input :color, as: :string
  	f.input :price, label: "Price(INR)"
  	f.input :images, as: :file, input_html: { multiple: true }
  	f.actions
  end
end
