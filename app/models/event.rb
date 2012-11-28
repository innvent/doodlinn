class Event < ActiveRecord::Base
  attr_accessible :description, :end_date, :name, :start_date
  has_many :votes

  def votes_per_date
    result = {}
    (start_date..end_date).each do |date|
      result[date] ||= 0
      votes.each do |vote|
        result[date] += 1 if vote.voted_on?(date)
      end
    end

    result
  end
end