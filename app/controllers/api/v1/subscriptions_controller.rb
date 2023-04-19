class Api::V1::SubscriptionsController < ApplicationController
  def create
    tea = Tea.find_by(id: params[:tea_id])
    subscription = tea.subscriptions.new(subscription_params)

    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :bad_request
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :status, :frequency, :tea_id, :customer_id)
  end
end