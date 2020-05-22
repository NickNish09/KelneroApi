class BillsChannel < ApplicationCable::Channel
  def subscribed
    stream_for bills_restaurant # canal específico de contas para cada restaurante
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def bills_restaurant
    @restaurant = Restaurant.find_by(subdomain: params[:subdomain])
  end
end
