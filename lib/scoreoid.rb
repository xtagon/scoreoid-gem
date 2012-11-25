require 'scoreoid/version'
require 'scoreoid/api_client'
require 'scoreoid/player'

module Scoreoid
	class NotConfiguredError < RuntimeError; end

	def self.configure(api_key, game_id)
		Scoreoid::APIClient.default_params = {api_key: api_key, game_id: game_id}
	end
end
