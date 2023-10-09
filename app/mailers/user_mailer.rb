class UserMailer < ApplicationMailer
  
  def product_created_email(product)
    @product = product
    mail(to: 'vermasubhashchandra2014@gmail.com', subject: 'New Product Created') do |format|
      format.text
    end
  end
end
