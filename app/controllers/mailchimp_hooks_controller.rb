# frozen_string_literal: true

class MailchimpHooksController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_user, only: :update_subscription

  def update_subscription
    subscription = case subscribe_params[:type]
                   when 'subscribe'
                     true
                   when 'unsubscribe'
                     false
                   else
                     @user.subscription
    end
    status = @user.update(subscription: subscription) ? :ok : :unprocessable_entity
    head status
  end

  def check
    head :ok
  end

  private

  def subscribe_params
    params.permit(:token, :type, :fired_at, data: [:action, :reason, :id, :list_id, :email, :email_type, :web_id, :ip_opt, :ip_signup, merges: []])
  end

  def set_user
    @user = User.find_by(email: subscribe_params[:data][:email])
  rescue ActiveRecord::RecordNotFound
    head :unprocessable_entity
  end
end
