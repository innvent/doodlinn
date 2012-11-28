require 'spec_helper'

describe Vote do
  let(:vote){Vote.new}

  it "um voto deve pertencer a um evento" do
    should belong_to(:event)
  end

  it "deve serializar/deseralizar arrays na propriedade dates_array" do
    dates = [Date.today, Date.today + 3.days]
    vote.dates_array = dates
    vote.save
    result = vote.dates_array
    result.should eq(dates)
  end

  it "deve validar que somente objetos do tipo 'date' podem existir no array" do
    dates = ["1", Date.today]
    vote.dates_array = dates
    vote.should_not be_valid
  end
end