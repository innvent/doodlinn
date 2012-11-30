class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new params[:event]
    if @event.save
      redirect_to token_path(@event.token)
    else
      render 'new'
    end
  end

  def destroy
    Event.find_by_token(params[:id]).destroy
    redirect_to events_path
  end

  def show
    @event = Event.find_by_token params[:token]
    @votes_presenter = VotesPresenter.new(@event)
  end

  def index
    @events = Event.order(:name)
  end

  def close_voting
    @event = Event.find_by_token params[:event_id]
    @event.close!
    @event.participants.each do |participant|
      EventNotification.notify_most_voted_date(participant, @event).deliver
    end
    redirect_to events_path
  end
end
