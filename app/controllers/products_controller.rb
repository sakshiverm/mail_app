class ProductsController < ApplicationController
  include JsonWebToken
  before_action :authenticate_user 

  def index
    @products = Product.all
  end

  def create  
    @product = Product.new(product_params)

    if @product.save
      UserMailer.product_created_email(@product).deliver_now
      render json: { status: 'Product created successfully', product: @product }, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def authenticate_user
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @current_user_id = decoded[0]['user_id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      render json: { error: 'Unauthorized access' }, status: :unauthorized
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
