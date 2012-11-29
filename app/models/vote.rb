# == Schema Information
#
# Table name: votes
#
#  id          :integer          not null, primary key
#  participant :string(255)
#  dates_array :binary
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#

class Vote < ActiveRecord::Base
  attr_accessible :dates_array, :participant
  validate :dates_array_contains_only_date_objects
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :participant, presence:   true,
                          format:     { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }

  belongs_to :event
  serialize :dates_array, Array

  def voted_on?(date)
    self.dates_array.include?(date)
  end

  private

    def dates_array_contains_only_date_objects
      elements_found = dates_array.select{|x| !x.instance_of?(Date)}
      errors[:dates_array] = "Dates array should contain only date objects!" if elements_found.any?
    end
end
