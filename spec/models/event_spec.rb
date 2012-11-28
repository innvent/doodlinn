#encoding: utf-8
require 'spec_helper'

describe Event do
  let!(:today){Date.today}
  let(:event){Event.new(name: "Evento XPTO", description: "Muito legal!", start_date: Date.today, end_date: today + 3)}

  it "um evento pode ter votos" do
    should have_many :votes
  end

  context "#votes_per_date" do
    it "deve retornar um hash com o número de votos para cada data de realização possível" do
      expected_result = {
        today => 2,
        today + 1 => 1,
        today + 2 => 0,
        today + 3 => 0
      }
      vote_johny = Vote.new(participant: "Johny", dates_array: [today])
      vote_mary = Vote.new(participant: "Mary", dates_array: [today, today + 1])
      event.votes << vote_johny
      event.votes << vote_mary
      event.votes_per_date.should eq(expected_result)      
    end
  end
end
