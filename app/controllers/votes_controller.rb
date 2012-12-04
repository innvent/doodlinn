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
      errors = @vote.errors.full_messages
      errors.each do |error|
        case error
        when "Participant is invalid"
          flash[:error] = "You must enter a valid email in the Participant field"
        when "Participant can't be blank"
          flash[:error] = "You must enter a valid email in the Participant field"
        when "Participant has already been taken"
          flash[:error] = "You can only vote once!"
        else
          flash[:error] = "Something went wrong!"
        end
      end
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
