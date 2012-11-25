require 'spec_helper'

describe Scoreoid::API do
	describe '.query' do
		it 'should query a Scoreoid API method and return the response as a string' do
			example_response = %q({"players": 7})
			given_params = {response: 'json', api_key: 'API_KEY', game_id: 'GAME_ID'}

			RestClient.stub(:post).and_return(example_response)
			RestClient.should_receive(:post).with('https://www.scoreoid.com/api/playerCount', given_params)

			api_response = Scoreoid::API.query('playerCount', given_params)
			api_response.should be_instance_of String
			api_response.should == example_response
		end
	end

	describe '.query_and_parse' do
		it 'should query a Scoreoid API method and parse the JSON response' do
			given_params = {api_key: 'API_KEY', game_id: 'GAME_ID'}
			params_plus_response_param = given_params.merge(response: 'json')

			Scoreoid::API.stub(:query).and_return(%q({"players": 7}))
			Scoreoid::API.should_receive(:query).with('playerCount', params_plus_response_param)

			parsed_response = Scoreoid::API.query_and_parse('playerCount', given_params)
			parsed_response.should be_instance_of Hash
			parsed_response.should == {'players' => 7}
		end

		it 'should raise an error if the Scoreoid API returned one in the JSON' do
			response_with_error = %q({"error": "The API key is broken or the game is not active"})

			Scoreoid::API.stub(:query).and_return(response_with_error)
			
			expect do
				Scoreoid::API.query_and_parse('getScores')
			end.to raise_error(Scoreoid::APIError, 'The API key is broken or the game is not active')
		end

		it 'should format the parameters before sending' do
			original_params = {start_date: Date.new(2010, 1, 1), end_date: Date.new(2012, 2, 3).to_time}
			formatted_params = {start_date: '2010-01-01', end_date: '2012-2-3'}

			Scoreoid::API.stub(:query).and_return(%q({"players": 7}))
			Scoreoid::API.stub(:prepare_params).and_return(formatted_params)
			Scoreoid::API.should_receive(:prepare_params).with(original_params)
			Scoreoid::API.query_and_parse('countPlayers', original_params)
		end
	end
end
