require 'date'

require 'multi_json'
require 'rest_client'

module Scoreoid
	# This exception is raised when the Scoreoid API returns an error response.
	class APIError < StandardError; end

	class APIClient
		REQUIRED_PARAMETERS = [:api_key, :game_id]

		@@default_params = Hash.new

		# Set the default request parameters.
		# Normally you would not call this directly, but instead use {Scoreoid.configure}.
		#
		# @param [Hash] params A hash of the default parameters to set.
		#
		# @return [Hash] Default request parameters.
		def self.default_params= params
			@@default_params = params
		end

		# Get the default request parameters.
		#
		# @raise [Scoreoid::NotConfiguredError] if required parameters are not set.
		#
		# @return Default request paremeters.
		def self.default_params
			REQUIRED_PARAMETERS.each do |param_key|
				unless @@default_params.key?(param_key)
					raise Scoreoid::NotConfiguredError, "Scoreoid Ruby has not been configured correctly. Please set the API key and game ID with Scoreoid.configure(api_key, game_id) before using this library."
				end
			end

			@@default_params
		end

		# Query the Scoreoid API and return the un-parsed response.
		# This is used internally and you should only call it if you really know what you're doing.
		#
		# @note If you want to query the Scoreoid API manually, you may want to use
		#    {Scoreoid::APIClient.api_call!} instead, which parses the JSON after.
		def self.api_call(api_method, params={})
			# Add :response => 'json' to the post parameters because the entire library
			# expects JSON responses.
			params = self.default_params.merge({response: 'json'}).merge(params)
			RestClient.post("https://www.scoreoid.com/api/#{api_method}", params)
		end

		# Query a Scoreoid API method and parse the response.
		#
		# @raise [Scoreoid::APIError] if the Scoreoid API returns an error response.
		#
		# @return [Hash] The Scoreoid API response parsed into a Hash.
		def self.api_call!(api_method, params={})
			# Convert Date parameters into a format that Scoreoid's API expects.
			params.each do |key, value|
				if [:start_date, :end_date].include?(key) and value.respond_to?(:strftime)
					params[key] = value.strftime '%Y-%m-%d'
				end
			end

			api_response = self.api_call(api_method, params)
			json = MultiJson.load(api_response)
			raise APIError, json['error'] if json.key? 'error'
			json
		end
	end
end
