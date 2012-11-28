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
    Event.find(params[:id]).destroy
    redirect_to new_event_url
  end

  def show
    @event = Event.find_by_token params[:token]
  end

end
