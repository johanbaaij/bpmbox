# frozen_string_literal: true

class CollectionsChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:username]
  end
end
