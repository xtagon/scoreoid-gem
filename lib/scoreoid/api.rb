require 'date'

require 'multi_json'
require 'rest_client'

module Scoreoid
	# This exception is raised when the Scoreoid API returns an error response.
	class APIError < StandardError; end

	# A singleton class with methods for querying the Scoreoid API.
	class API
		class << self
			# Query a given Scoreoid API method and return the repsonse as a string.
			#
			# @param [String] api_method The Scoreoid API method to query
			# @param [Hash] params Parameters to include in the API request
			#
			# @return [String] The Scoreoid API response
			#
			# @see .query_and_parse
			def query(api_method, params={})
				params = self.prepare_params(params)
				params.merge!(self.default_params ||= {})
				RestClient.post("https://www.scoreoid.com/api/#{api_method}", params)
			end

			# Query a given Scoreoid API method and parse the JSON response.
			#
			# The response type is set to 'json' for you automatically.
			#
			# @param [String] api_method The Scoreoid API method to query
			# @param [Hash] params Parameters to include in the API request.
			#
			# @raise [Scoreoid::APIError] if the Scoreoid API returns an error response.
			#
			# @return [Hash] The Scoreoid API response parsed into a Hash.
			#
			# @see .query
			# @see .prepare_params
			def query_and_parse(api_method, params={})
				params = params.merge(response: 'json')

				api_response = self.query(api_method, params)
				parsed_result = MultiJson.load(api_response)

				raise APIError, parsed_result['error'] if parsed_result.key? 'error'

				parsed_result
			end

			# Attempt to coerce parameters into formats that the Scoreoid API expects.
			#
			# @param [Hash] params A hash of any parameters you wish to format.
			#
			# @option params [Date, Time, String] :start_date
			# @option params [Date, Time, String] :end_date
			#
			# @return [Hash] The formatted parameters, ready to use in an API query.
			def prepare_params(params)
				params.each do |key, value|
					if [:start_date, :end_date].include?(key) and value.respond_to?(:strftime)
						params[key] = value.strftime '%Y-%m-%d'
					end
				end
				params
			end

			# Default API request parameters used by {.query}
			#
			# This would normally be set with {Scoreoid.configure}
			attr_accessor :default_params
		end
	end
end