class Api::V0::CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @customer = Customer.find(params[:id])
    render json: SubscriptionSerializer.new(@customer.subscriptions), status: 200
  end
end