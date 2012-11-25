require 'scoreoid/version'
require 'scoreoid/api_client'
require 'scoreoid/player'

module Scoreoid
	# This exception is raised when Scoreoid Ruby is used without first being configured.
	# To configure Scoreoid Ruby, see {Scoreoid.configure}.
	class NotConfiguredError < RuntimeError; end

	# Configure Scoreoid Ruby with your Scoreoid API key and game ID.
	# This must be done once before calling any Scoreoid API methods.
	#
	# @example
	#    Scoreoid.configure(ENV['SCOREOID_API_KEY'], ENV['SCOREOID_GAME_ID'])
	#
	# @return [Hash] A hash of the parameters you just configured.
	def self.configure(api_key, game_id)
		Scoreoid::APIClient.default_params = {api_key: api_key, game_id: game_id}
	end
end
