class CartsController < ApiController 

	before_action :get_cart

	def show
		if @cart.nil?
			render json: {error: "Cart not found"}, status: :not_found
		else
			render json: {
				# cart: CartSerializer.new(@cart).serializable_hash, 
				# line_items: LineItemSerializer.new(@cart.line_items).serializable_hash
			}, status: :ok
		end
	end

	def add_item
		cart = Cart.find_or_create_by(user_id: @current_user.id)
		cart.line_items.new()
	end

	def remove_item
	end

	private
	def get_cart
		@cart = Cart.find_or_create_by(user_id: @current_user.id)
	end
end