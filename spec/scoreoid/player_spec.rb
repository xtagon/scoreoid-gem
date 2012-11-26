require 'spec_helper'

describe Scoreoid::Player do
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

	describe '.create' do
		it 'should create the player and return the parsed API response' do
			success_response = {'success' => ['The player has been created']}
			params = {username: 'AzureDiamond', password: 'hunter2'}

			Scoreoid::API.stub(:query_and_parse).and_return(success_response)
			Scoreoid::API.should_receive(:query_and_parse).with('createPlayer', params)

			response = Scoreoid::Player.create(params)
			response.should == success_response
		end
	end

	describe '.edit' do
		it 'should edit the player and return the parsed API response' do
			success_response = {'success' => ['The player has been updated']}
			params = {username: 'AzureDiamond', password: '*******'}

			Scoreoid::API.stub(:query_and_parse).and_return(success_response)
			Scoreoid::API.should_receive(:query_and_parse).with('editPlayer', params)

			response = Scoreoid::Player.edit(params)
			response.should == success_response
		end
	end
end
