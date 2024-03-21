class ReviewsController < ApiController

	skip_before_action :authenticate_request, only: [:index]
	before_action :get_product, only: [:index]
	before_action :get_review, only: [:update]

	def index 
		reviews = Review.where(product_id: @product.id)
		avg_rating = reviews.pluck(:rating).sum / reviews.count
		render json: {reviews: ReviewSerializer.new(reviews).serializable_hash, avg_rating: avg_rating}, status: :ok
	end

	def create
		review = Review.new(review_param)
		review.user_id = @current_user.id

		if review.save
			review.images.attach(review_param[:images])
			render json: ReviewSerializer.new(review).serializable_hash, status: :created
		else
			render json: {errors: review.errors}, status: :unprocessable_entity
		end
	end

	def update
		return if @review.nil?

		@review.images.purge if review_param[:images].present?

		if @review.update(review_param)
			@review.images.attach(review_param[:images])
			render json: ReviewSerializer.new(@review).serializable_hash, status: :ok 
		else
			render json: {errors: @review.errors}, status: :unprocessable_entity
		end
	end

	private
	def get_product
		@product = Product.find_by(id: params[:product_id]) 

		if @product.nil?
			render json: {message: "Product not found"}, status: :not_found
		end
	end

	def get_review
		@review = Review.find_by(id: params[:id])
		if @review.nil?
			render json: {message: "Review does not exist"}, status: :not_found
		end
	end

	def review_param
		params.require(:review).permit(:rating, :description, :product_id, :user_id, images: [])
	end

end