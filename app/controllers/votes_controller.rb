class VotesController < ApplicationController
  def new
    @event = Event.find_by_token params[:event_id]
    # @vote = @event.votes.build
    @vote = Vote.new
  end

  def create
    @event = Event.find_by_token params[:event_id]
    # @vote = Vote.new(:event =>@event)
    @vote = @event.votes.new(params[:vote])
  end
end
