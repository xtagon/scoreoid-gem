require 'spec_helper'

describe Scoreoid::Player do
	describe '.create' do
		it 'should return true on successfully creating a player' do
			success_response = %q({"success":["The player has been created"]})
			params = {username: 'AzureDiamond', password: 'hunter2'}

			Scoreoid::API.stub(:query_and_parse).and_return(success_response)
			Scoreoid::API.should_receive(:query_and_parse).with('createPlayer', params)

			expect do
				Scoreoid::Player.create(params).should be_true
			end.to_not raise_error
		end
	end

	describe '.count' do
		it 'should count players with no query parameters' do
			Scoreoid::API.stub(:query_and_parse).and_return({'players' => 7})
			Scoreoid::API.should_receive(:query_and_parse).with('countPlayers', {})
			count = Scoreoid::Player.count
			count.should == 7
		end

		it 'should count players with query parameters' do
			params = {start_date: '2011-11-01', end_date: Time.now}
			Scoreoid::API.stub(:query_and_parse).and_return({'players' => 7})
			Scoreoid::API.should_receive(:query_and_parse).with('countPlayers', params)
			count = Scoreoid::Player.count(params)
			count.should == 7
		end
	end
end
