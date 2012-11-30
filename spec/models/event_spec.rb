#encoding: utf-8
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
#  close_date  :datetime
#

require 'spec_helper'

describe Event do
  let!(:today){Date.today}
  let(:event){Event.new(name: "Evento XPTO", description: "Muito legal!", start_date: Date.today, end_date: today + 3)}

  it "um evento pode ter votos" do
    should have_many :votes
  end

  context "#votes_per_date" do
    it "retorna um hash com o número de votos para cada data de realização possível" do
      expected_result = {
        today => 2,
        today + 1 => 1,
        today + 2 => 0,
        today + 3 => 0
      }
      create_sample_votes
      event.votes_per_date.should eq(expected_result)
    end
  end

  describe "#date_with_most_votes" do
    context "quando existem votos" do
      before :each do
        create_sample_votes
      end
      context "quando só existe uma data com o maior número de votos" do
        it "retorna array contendo somente essa data" do
          event.dates_with_most_votes.should eq([today])
        end
      end
      context "quando existe mais de uma data com o maior número de votos" do
        it "retorna array com essas datas" do
          event.votes << Vote.new(participant: "mary@example.com", dates_array: [today + 1])
          event.dates_with_most_votes.should eq([today, today + 1])
        end
      end
    end

    context "quando não existem votos" do
      it "retorna array vazio" do
        event.dates_with_most_votes.should be_empty
      end
    end
  end

  it "adiciona um token apos ser criado" do
    event.save
    event.token.should_not be_blank
  end

  def create_sample_votes
    vote_johny = Vote.new(participant: "john@example.com", dates_array: [today])
    vote_mary = Vote.new(participant: "peter@example.com", dates_array: [today, today + 1])
    event.votes << vote_johny
    event.votes << vote_mary
  end
end
