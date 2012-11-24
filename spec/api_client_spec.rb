require 'spec_helper'

describe Scoreoid::APIClient do
	describe 'self.api_call' do
		it 'should call Scoreoid API methods with default parameters' do
			example_response = %q({"players": 7})
			default_params = {api_key: 'API_KEY', game_id: 'GAME_ID'}

			Scoreoid::APIClient.stub(:default_params).and_return(default_params)
			RestClient.stub(:post).and_return(example_response)
			RestClient.should_receive(:post).with('https://www.scoreoid.com/api/playerCount', default_params)

			api_response = Scoreoid::APIClient.api_call('playerCount')
			api_response.should be_instance_of String
			api_response.should == example_response
		end
	end

	describe 'self.countPlayers' do
		it 'should call the countPlayers() Scoreoid API method' do
			Scoreoid::APIClient.stub(:api_call).and_return(%q({"players":7}))
			Scoreoid::APIClient.should_receive(:api_call).with('countPlayers')
			Scoreoid::APIClient.countPlayers
		end

		it 'should parse the JSON result into a Hash' do
			Scoreoid::APIClient.stub(:api_call).and_return(%q({"players":7}))
			result = Scoreoid::APIClient.countPlayers
			result.should be_instance_of Hash
			result.should == {'players' => 7}
		end
	end
end
