class Api::V0::SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: { error: "Incorrect input, please input all information so you can subscribe to this tea" }, status: 400
    end
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end