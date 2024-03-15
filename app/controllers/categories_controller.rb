class CategoriesController < ApiController

	skip_before_action :authenticate_request

	def index
		categories = Category.all

		if categories
			render json: CategorySerializer.new(categories).serializable_hash, status: :ok
		else
			render json: { data: [], message: 'Categories not found' }, status: :ok
		end
	end
end