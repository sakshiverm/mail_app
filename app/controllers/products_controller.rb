class ProductsController < ApplicationController

  def index
    @product = Product.all
    render json: @product
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

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
