class VotesController < ApplicationController
  before_filter :find_event, :check_event_is_opened
  
  def new
    # @vote = @event.votes.build
    @vote = Vote.new
  end

  def create
    # @vote = Vote.new(:event =>@event)
    @vote = @event.votes.new(params[:vote])
    if params[:dates]
      dates_array = params[:dates].map{ |x| Date.strptime(x, '%Y-%m-%d') }
    else
      dates_array = []
    end
    @vote.dates_array = dates_array
    if @vote.save
      flash[:notice] = "Voted!"
      redirect_to token_path(@event)
    else
      flash[:error] = "Something went wrong!"
      render 'new'
    end
  end

  private
  def find_event
    @event = Event.find_by_token params[:event_id]
  end

  def check_event_is_opened
    if @event.is_closed?
      flash[:error] = "This event is closed for voting!"
      redirect_to event_path(@event)
    end
  end
end
