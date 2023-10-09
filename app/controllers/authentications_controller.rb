class AuthenticationsController < ApplicationController
  include JsonWebToken
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = self.jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
