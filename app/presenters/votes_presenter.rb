class VotesPresenter
  include ActionView::Helpers::OutputSafetyHelper

  def initialize(event)
    @event = event
  end

  def build_dates_by_participant_votes_table
    html_to_return = "<table class='table'>"
    html_to_return << "<thead><tr><th>Participante</th>"

    dates = (@event.start_date..@event.end_date).to_a
    dates.each { |d| html_to_return << "<th style='text-align: center'>#{I18n.l(d, format: :short)}</th>" }
    html_to_return << '</tr></thead><tbody>'

    @event.votes.each do |v|
      html_to_return << "<tr><td>#{v.participant}</td>"
      (@event.start_date..@event.end_date).each do |d|
        html_to_return << "<td style='text-align: center'>"
        html_to_return << if v.dates_array.include?(d)
          '<span class="label label-success">Ok!</span>'
        else
          '<span class="label label-important">No!</span>'
        end
        html_to_return << '</td>'
      end
      html_to_return << '</tr>'
    end
    html_to_return << '</tbody><tfoot><tr><th>Total</th>'
    @event.votes_per_date.each { |k, v| html_to_return << "<th style='text-align: center'>#{v}</th>" }

    html_to_return << '</tr></tfoot></table>'

    raw(html_to_return)
  end

end