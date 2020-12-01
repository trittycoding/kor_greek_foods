class UsersController < ApplicationController
  def index; end

  def edit_account
    @user = User.find_by(params[:email])
  end

  def post_account_changes
    @user = current_user
    respond_to do |changes|
      if @user.update(user_params)
        changes.html { redirect_to(root_url, alert: 'Account details successfully updated') }
        changes.json { render :root_path, status: :ok, location: @user }
      else
        changes.html { render :edit_account }
        changes.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params.permit(:name, :address, :province_id)
  end
end
