class CartsController < ApiController 

	before_action :get_cart

	def index
		@cart.total_price = @cart.line_items.pluck(:total_price).sum
		if @cart.save 
			render json: {
				cart: CartSerializer.new(@cart).serializable_hash,
				line_items: LineItemSerializer.new(@cart.line_items).serializable_hash,
				total_price: @cart.total_price
			}, status: :ok
		end
	end

	private

	def get_cart
		@cart = Cart.find_or_create_by(user_id: @current_user.id)
	end

end