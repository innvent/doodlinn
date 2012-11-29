# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  start_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  token       :string(255)
#

class Event < ActiveRecord::Base
  attr_accessible :description, :end_date, :name, :start_date, :token
  has_many :votes
  before_create :create_token

  def participants
    self.votes.map{|x| x.participant}
  end

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

  def dates_with_most_votes
    hash = votes_per_date
    max_votes = hash.values.max
    hash.select{ |k, v| v == max_votes and v != 0 }.keys
  end

  def is_a_most_voted_date?(date)
    dates_with_most_votes.include?(date)
  end

  def to_param
    self.token
  end

  def close!
    self.close_date = DateTime.now
    self.save!
  end

  def is_closed?
    self.close_date and self.close_date < DateTime.now
  end

  private
  def create_token
    self.token = SecureRandom.urlsafe_base64[0..10]
  end
end
