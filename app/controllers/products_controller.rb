class ProductsController < ApiController

	skip_before_action :authenticate_request

	def index
		products = Product.all

		if products
			render json: ProductSerializer.new(products).serializable_hash, status: :ok
		else
			render json: { data: [], message: 'Products not found' }, status: :ok
		end
	end

	def show
		product = Product.find_by_id(params[:id])

		if product
			render json: ProductSerializer.new(product).serializable_hash, status: :ok 
		else
			render json: { error: {message: 'Product not found'} }, status: :not_found 
		end
	end

end