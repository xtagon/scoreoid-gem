require 'multi_json'
require 'rest_client'

module Scoreoid
	class APIClient
		def self.api_call(api_method)
			RestClient.post("https://www.scoreoid.com/api/#{api_method}", self.default_params)
		end

		def self.countPlayers
			api_response = self.api_call('countPlayers')
			MultiJson.load(api_response)
		end
	end
end
