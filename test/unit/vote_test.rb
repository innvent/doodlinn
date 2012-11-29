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

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
