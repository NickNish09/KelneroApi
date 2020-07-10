# channel to receive broadcasts from waiter side
class WaiterCommandsChannel < ApplicationCable::Channel
  def subscribed
    stream_for commands_restaurant # canal específico de comandas para cada restaurante
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def commands_restaurant
    Restaurant.find_by(subdomain: params[:subdomain])
  end
end
