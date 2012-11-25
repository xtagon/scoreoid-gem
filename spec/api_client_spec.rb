require 'spec_helper'

describe Scoreoid::APIClient do
	describe 'self.default_params' do
		it 'should be set to empty hash by default' do
			Scoreoid::APIClient.class_variable_get(:@@default_params).should be_instance_of Hash
		end

		context 'setting default parameters' do
			it 'should set default parameters when required parameters are provided' do
				example_params = {api_key: 'API_KEY', game_id: 'GAME_ID'}
				Scoreoid::APIClient.default_params = example_params
				Scoreoid::APIClient.class_variable_get(:@@default_params).should == example_params
			end
		end

		context 'getting default parameters' do
			it 'returns exactly the parameters which were set' do
				example_params = {api_key: 'API_KEY', game_id: 'GAME_ID'}
				Scoreoid::APIClient.default_params = example_params
				Scoreoid::APIClient.default_params.should == example_params
			end

			it 'raises an error if required parameters are absent' do
				Scoreoid::APIClient.default_params = {api_key: 'API_KEY'} # missing :game_id
				expect do
					Scoreoid::APIClient.default_params
				end.to raise_error Scoreoid::NotConfiguredError

				Scoreoid::APIClient.default_params = {game_key: 'GAME_ID'} # missing :api_key
				expect do
					Scoreoid::APIClient.default_params
				end.to raise_error Scoreoid::NotConfiguredError
			end
		end
	end

	describe 'self.api_call' do
		it 'should call Scoreoid API methods with default parameters' do
			# We're testing that :response => 'json' is added to the parameters
			# because the entire library expects JSON responses.

			example_response = %q({"players": 7})
			default_params = {api_key: 'API_KEY', game_id: 'GAME_ID'}
			post_params = default_params.merge({response: 'json'})

			Scoreoid::APIClient.stub(:default_params).and_return(default_params)
			RestClient.stub(:post).and_return(example_response)
			RestClient.should_receive(:post).with('https://www.scoreoid.com/api/playerCount', post_params)

			api_response = Scoreoid::APIClient.api_call('playerCount')
			api_response.should be_instance_of String
			api_response.should == example_response
		end

		it 'should call Scoreoid API methods with additional parameters' do
			example_response = %q({"players": 7})
			default_params = {api_key: 'API_KEY', game_id: 'GAME_ID'}
			additional_params = {platform: 'Windows'}
			post_params = default_params.merge(additional_params).merge({response: 'json'})

			Scoreoid::APIClient.stub(:default_params).and_return(default_params)
			RestClient.stub(:post).and_return(example_response)
			RestClient.should_receive(:post).with('https://www.scoreoid.com/api/playerCount', post_params)

			Scoreoid::APIClient.api_call('playerCount', additional_params)
		end
	end

	describe 'self.countPlayers' do
		it 'should call the Scoreoid API method and parse the JSON result into a Hash' do
			Scoreoid::APIClient.stub(:api_call).and_return(%q({"players":7}))
			result = Scoreoid::APIClient.countPlayers
			result.should be_instance_of Hash
			result.should == {'players' => 7}
		end

		it 'should raise an error if the Scoreoid API returns an error' do
			example_response = %q({"error": "The API key is broken or the game is not active"})
			Scoreoid::APIClient.stub(:api_call).and_return(example_response)
			
			expect do
				Scoreoid::APIClient.countPlayers
			end.to raise_error(Scoreoid::APIError, 'The API key is broken or the game is not active')
		end
	end
end
