require 'scoreoid/version'
require 'scoreoid/api'
require 'scoreoid/player'

# The main Scoreoid Ruby namespace.
module Scoreoid
	# Configure Scoreoid Ruby by setting default API request parameters.
	# You can set any parameters here, but it is only recommended to set
	# :api_key and :game_id as they are common to all API methods.
	#
	# @param [Hash] params A hash of default parameters to set
	#
	# @option params [String] :api_key Your Scoreoid API key
	# @option params [String] :game_id Your Scoreoid game ID
	#
	# @return [Hash] The parameters you just set
	def self.configure(params)
		Scoreoid::API.default_params = params
	end
end
