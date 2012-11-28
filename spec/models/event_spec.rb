require 'spec_helper'

describe Event do

  it "um evento pode ter votos" do
    should have_many :votes
  end
end