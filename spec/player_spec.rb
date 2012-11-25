require 'spec_helper'

describe Scoreoid::Player do
	describe '.count' do
		it 'should count players with no criteria' do
			Scoreoid::APIClient.should_receive(:api_call!).with('countPlayers', {}).and_return({'players' => 7})
			how_many_players = Scoreoid::Player.count
			how_many_players.should be_kind_of Integer
			how_many_players.should >= 0
		end

		it 'should count players with criteria' do
			params = {start_date: '2012-11-01'}
			Scoreoid::APIClient.should_receive(:api_call!).with('countPlayers', params).and_return({'players' => 7})
			how_many_players = Scoreoid::Player.count(params)
			how_many_players.should be_kind_of Integer
			how_many_players.should >= 0
		end
	end
end
