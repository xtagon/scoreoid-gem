module Scoreoid
	# Represents the game players.
	class Player
		# Get the number of players for a game.
		#
		# @example Count the total number of players
		#    puts "This game has #{Scoreoid::Player.count} total players."
		#
		# @example Count new players
		#    count = Scoreoid::Player.count(start_date: '2012-11-01')
		#    puts "There are #{count} new players since 2012-11-01."
		#
		# @param [Hash] params Parameters to include in the API request.
		#    Default parameters set with {Scoreoid.configure} will be included for you.
		#
		# @option params [String] :api_key Your Scoreoid API key
		# @option params [String] :game_id The game ID
		# @option params [Date, Time, String] :start_date optional
		# @option params [Date, Time, String] :end_date optional
		#
		# @return [Integer] The number of players.
		def self.count(params={})
			Scoreoid::API.query_and_parse('countPlayers', params)['players']
		end

		# Create a new player for a game.
		#
		# @example Create a player named Bob
		#    Scoreoid::Player.create(username: 'bob', first_name: 'Bob', last_name: 'Ross')
		#
		# @param [Hash] params Parameters to include in the API request.
		#    Default parameters set with {Scoreoid.configure} will be included for you.
		#
		# @option params [String] :api_key Your Scoreoid API key
		# @option params [String] :game_id The game ID
		# @option params [String] :username The player's username (required)
		# @option params [String] :password Optional
		# @option params [String] :score optional
		# @option params [String] :difficulty optional
		# @option params [String] :unique_id optional
		# @option params [String] :first_name optional
		# @option params [String] :last_name optional
		# @option params [String] :email optional
		# @option params [String] :created optional
		# @option params [String] :updated optional
		# @option params [String] :bonus optional
		# @option params [String] :achievements optional
		# @option params [String] :best_score optional
		# @option params [String] :gold optional
		# @option params [String] :money optional
		# @option params [String] :kills optional
		# @option params [String] :lives optional
		# @option params [String] :time_played optional
		# @option params [String] :unlocked_levels optional
		# @option params [String] :unlocked_items optional
		# @option params [String] :inventory optional
		# @option params [String] :last_level optional
		# @option params [String] :current_level optional
		# @option params [String] :current_time optional
		# @option params [String] :current_bonus optional
		# @option params [String] :current_kills optional
		# @option params [String] :current_achievements optional
		# @option params [String] :current_gold optional
		# @option params [String] :current_unlocked_levels optional
		# @option params [String] :current_unlocked_items optional
		# @option params [String] :current_lives optional
		# @option params [String] :xp optional
		# @option params [String] :energy optional
		# @option params [String] :boost optional
		# @option params [String] :latitude optional
		# @option params [String] :longitude optional
		# @option params [String] :game_state optional
		# @option params [String] :platform optional
		#
		# @raise [Scoreoid::APIError] if the player could not be created
		#
		# @return [Hash] The API response from Scoreoid (should contain a success message)
		def self.create(params={})
			Scoreoid::API.query_and_parse('createPlayer', params)
		end

		# Edit player information.
		#
		# @example Update John's first and last name
		#    Scoreoid::Player.edit(username: 'john', first_name: 'John', last_name: 'Dough')
		#
		# @param [Hash] params Parameters to include in the API request.
		#    Default parameters set with {Scoreoid.configure} will be included for you.
		#
		# @option params [String] :api_key Your Scoreoid API key
		# @option params [String] :game_id The game ID
		# @option params [String] :username The player's username (required)
		# @option params [String] :password Optional
		# @option params [String] :score optional
		# @option params [String] :difficulty optional
		# @option params [String] :unique_id optional
		# @option params [String] :first_name optional
		# @option params [String] :last_name optional
		# @option params [String] :email optional
		# @option params [String] :created optional
		# @option params [String] :updated optional
		# @option params [String] :bonus optional
		# @option params [String] :achievements optional
		# @option params [String] :best_score optional
		# @option params [String] :gold optional
		# @option params [String] :money optional
		# @option params [String] :kills optional
		# @option params [String] :lives optional
		# @option params [String] :time_played optional
		# @option params [String] :unlocked_levels optional
		# @option params [String] :unlocked_items optional
		# @option params [String] :inventory optional
		# @option params [String] :last_level optional
		# @option params [String] :current_level optional
		# @option params [String] :current_time optional
		# @option params [String] :current_bonus optional
		# @option params [String] :current_kills optional
		# @option params [String] :current_achievements optional
		# @option params [String] :current_gold optional
		# @option params [String] :current_unlocked_levels optional
		# @option params [String] :current_unlocked_items optional
		# @option params [String] :current_lives optional
		# @option params [String] :xp optional
		# @option params [String] :energy optional
		# @option params [String] :boost optional
		# @option params [String] :latitude optional
		# @option params [String] :longitude optional
		# @option params [String] :game_state optional
		# @option params [String] :platform optional
		#
		# @raise [Scoreoid::APIError] if the player could not be updated
		#
		# @return [Hash] The API response from Scoreoid (should contain a success message)
		def self.edit(params={})
			Scoreoid::API.query_and_parse('editPlayer', params)
		end

		# Updates a players field.
		#
		# @example Update John's e-mail address
		#    Scoreoid::Player.update_field(username: 'john', field: 'email', value: 'john@example.com')
		#
		# @param [Hash] params Parameters to include in the API request.
		#    Default parameters set with {Scoreoid.configure} will be included for you.
		#
		# @option params [String] :api_key Your Scoreoid API key
		# @option params [String] :game_id The game ID
		# @option params [String] :username The player's username (required)
		# @option params [String] :field The field name to update (see {.edit})
		# @option params [String] :value The value to set
		#
		# @raise [Scoreoid::APIError] if the field could not be updated
		#
		# @return [Hash] The API response from Scoreoid (should contain a success message)
		def self.update_field(params={})
			Scoreoid::API.query_and_parse('updatePlayerField', params)
		end
	end
end
