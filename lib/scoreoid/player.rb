require 'scoreoid/api_client'

module Scoreoid
	class Player
		def self.count
			Scoreoid::APIClient.countPlayers['players']
		end
	end
end
