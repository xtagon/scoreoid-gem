require 'multi_json'
require 'rest_client'

module Scoreoid
	class APIClient
		REQUIRED_PARAMETERS = [:api_key, :game_id]

		@@default_params = Hash.new

		def self.default_params= params
			@@default_params = params
		end

		def self.default_params
			REQUIRED_PARAMETERS.each do |param_key|
				unless @@default_params.key?(param_key)
					raise Scoreoid::NotConfiguredError, "Scoreoid Ruby has not been configured correctly. Please set the API key and game ID with Scoreoid.configure(api_key, game_id) before using this library."
				end
			end

			@@default_params
		end

		def self.api_call(api_method)
			# Add :response => 'json' to the post parameters because the entire library
			# epects JSON responses.
			post_params = self.default_params.merge({response: 'json'})
			RestClient.post("https://www.scoreoid.com/api/#{api_method}", post_params)
		end

		def self.countPlayers
			api_response = self.api_call('countPlayers')
			MultiJson.load(api_response)
		end
	end
end
