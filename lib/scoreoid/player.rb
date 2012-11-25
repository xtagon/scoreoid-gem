require 'scoreoid/api_client'

module Scoreoid
	class Player
		# @return [Integer] The total number of players for the game.
		#
		# @example
		#    Scoreoid.configure 'YOUR_API_KEY', 'YOUR_GAME_ID'
		#    
		#    puts "This game has #{Scoreoid::Player.count} players!"
		def self.count
			Scoreoid::APIClient.countPlayers['players']
		end
	end
end
