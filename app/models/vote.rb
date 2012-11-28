class Vote < ActiveRecord::Base
  attr_accessible :dates_array, :participant
  validate :dates_array_contains_only_date_objects
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
