class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user.to_json
  end
  
  def update
    if current_user.update_attributes(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render :show
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end