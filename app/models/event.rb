class Event < ActiveRecord::Base
  attr_accessible :description, :end_date, :name, :start_date, :token
  has_many :votes
  before_create :create_token

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

  private
  def create_token
    self.token = SecureRandom.urlsafe_base64[0..10]
  end
end