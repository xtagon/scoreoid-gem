module Scoreoid
	# Represents the game players.
	class Player
		# Get the number of players for the game.
		#
		# @example Count the total number of players
		#    puts "This game has #{Scoreoid::Player.count} total players."
		#
		# @example Count new players
		#    count = Scoreoid::Player.count(start_date: '2012-11-01')
		#    puts "There are #{count} new players since 2012-11-01."
		#
		# @param [Hash] params Optional criteria for counting players.
		# @option params [Date, Time, String] :start_date Start date ("YYYY-MM-DD" if passed as String)
		# @option params [Date, Time, String] :end_date End date ("YYYY-MM-DD" if passed as String)
		#
		# @return [Integer] The number of players.
		def self.count(params={})
			Scoreoid::API.query_and_parse('countPlayers', params)['players']
		end
	end
end
