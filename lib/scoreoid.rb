require 'scoreoid/version'
require 'scoreoid/api'
require 'scoreoid/player'

# The main Scoreoid Ruby namespace.
#
# To get started, set your Scoreoid API key and game ID with {Scoreoid.configure}.
# Then you can use {Scoreoid::API.query_and_parse} to query any Scoreoid API method.
# See the {http://wiki.scoreoid.net/category/api/ Scoreoid Wiki} for information
# on available API methods.
module Scoreoid
	# Configure Scoreoid Ruby by setting default API request parameters.
	# You can set any parameters here, but it is only recommended to set
	# :api_key and :game_id as they are common to all API methods.
	#
	# @example Setting your API key and game ID from environment variables:
	#    Scoreoid.configure(api_key: ENV['SCOREOID_API_KEY'], game_id: ENV['SCOREOID_GAME_ID'])
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
