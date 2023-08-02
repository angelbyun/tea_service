class Api::V0::SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: { error: "Your subscription was unsuccessful"}, status: 400
    end
  end

  def cancel
    @subscription = Subscription.find(params[:id])
    @subscription.update(status: "Canceled")
    render json: { message: "Your subscription is now canceled" }, status: 200
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
  end
end