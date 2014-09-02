class My::AuthenticationsController < ApplicationController

  def destroy
    @user = current_user
    @authentication = @user.authentications.find(params[:id])
    if @user.authentications.count == 1 && @user.email.blank?
      flash[:danger] = t('authentications.not_destroyed')
    else
      @authentication.destroy
      flash[:success] = t('authentications.destroyed', provider: @authentication.provider.capitalize)
    end
    redirect_to my_profile_path
  end
end
