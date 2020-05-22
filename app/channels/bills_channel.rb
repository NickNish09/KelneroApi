class BillsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bills_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
