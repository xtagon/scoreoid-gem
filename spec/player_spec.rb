require 'spec_helper'

describe Scoreoid::Player do
	it 'should count players' do
		Scoreoid::APIClient.should_receive(:countPlayers).and_return({'players' => 7})
		how_many_players = Scoreoid::Player.count
		how_many_players.should be_kind_of Integer
		how_many_players.should >= 0
	end
end
