class EventNotification < ActionMailer::Base
  default from: "sistemas@innvent.com.br"

  def notify_most_voted_date(participant, event)
    @event = event
    mail(to: participant, subject: "Event #{event.name} notification")
  end
end
