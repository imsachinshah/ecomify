class LineItemsController < ApiController

	before_action :get_product, only: :create
	before_action :get_cart
	before_action :get_item, only: [:add_item_quantity, :remove_item_quantity]

	def create
		cart_item = @cart.line_items.new(item_param)
		cart_item.total_price = @product.price * cart_item.quantity

		if cart_item.save
			render json: { success: "Item is added to cart"}, status: :created
		else
			render json: { error: cart_item.errors.full_messages}, status: :unprocessable_entity
		end
	end

	def destroy
		cart_item = @cart&.line_items.find_by(id: params[:id])
		
		if cart_item.nil?
			render json: { error: "Item not found"}, status: :not_found
		else 
			cart_item.destroy
			render json: { success: "Item is removed from cart"}, status: :ok 
		end
	end

	def add_item_quantity
		return render json: {error: "Item not found"}, status: :not_found  if @item.nil?

		if @item.update(quantity: @item.quantity + 1)
			render json: {
				line_item: {
					id: @item.id,
					quantity: @item.quantity
				},
				meta: {
					success: "Item is successfully Added"
				}
			}, status: :ok
		end
	end

	def remove_item_quantity
		return render json: {error: "Item not found"}, status: :not_found  if @item.nil?

		if @item.quantity - 1 != 0
			if @item.update(quantity: @item.quantity - 1)
				render json: {
					line_item: {
						id: @item.id,
						quantity: @item.quantity
					},
					meta: {
						success: "Item is successfully Removed"
					}
				}, status: :ok
			end
		else
			@item.destroy
			render json: {
				message: "Item removed from cart"
			}, status: :ok 
		end
	end

	private
	def item_param
		params.require(:item).permit(:id, :product_id, :quantity)
	end

	def get_product
		@product = Product.find_by(id: params[:item][:product_id]) if params[:item][:product_id].present?
	end

	def get_cart
		@cart = Cart.find_or_create_by(user_id: @current_user.id)
	end

	def get_item
		@item = @cart.line_items.find_by(id: params[:id])
	end

end