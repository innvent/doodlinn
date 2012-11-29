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
end
