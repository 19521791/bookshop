class SignedUrlChannel < ApplicationCable::Channel
  def subscribed
    stream_from "signed_urls_channel"
  end

  def unsubscribed; end
end
