require 'chronic'
require 'multi_json'
require 'rest_client'

module Scoreoid
	# This exception is raised when the Scoreoid API returns an error response.
	class APIError < StandardError; end

	# A singleton class with methods for querying the Scoreoid API.
	class API
		class << self
			# Default API request parameters used by {.query}
			#
			# This would normally be set with {Scoreoid.configure}
			attr_accessor :default_params

			# Query a given Scoreoid API method and return the repsonse as a string.
			#
			# Supplied parameters will be prepared with {.prepare_params} before sending.
			# This is so that you can, for example,  supply a Date object for :start_date
			# even though the Scoreoid API expects it to be a string formatted as "YYYY-MM-DD".
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
			# @raise [MultiJson::DecodeError] if the Scoreoid API response can't be parsed
			#    (report a bug if this happens!)
			#
			# @return [Hash] The Scoreoid API response parsed into a Hash.
			#
			# @see .query
			def query_and_parse(api_method, params={})
				# We're gonna parse JSON, so ask for JSON
				params = params.merge(response: 'json')

				# Query Scoreoid
				api_response = self.query(api_method, params)

				# Fix for API responses that return arrays (they can't be parsed by MultiJson)
				if api_response =~ /\A\[/ and api_response =~ /\]\Z/
					api_response.sub!(/\A\[/, '') # Remove leading bracket
					api_response.sub!(/\]\Z/, '') # Remove trailing bracket
				end

				# Parse the response
				parsed_result = MultiJson.load(api_response)

				# Raise an error if the response JSON contained one
				raise APIError, parsed_result['error'] if parsed_result.key? 'error'

				# Return the parsed result
				parsed_result
			end

			# Attempt to coerce parameters into formats that the Scoreoid API expects.
			#
			# Date parameters will be parsed with Chronic, so you can supply dates in
			# natural language such as "may 5th 2012" or "1 year ago".
			#
			# @param [Hash] params A hash of any parameters you wish to format.
			#
			# @option params [#to_s, #strftime] :start_date
			# @option params [#to_s, #strftime] :end_date
			#
			# @return [Hash] The formatted parameters, ready to use in an API query.
			def prepare_params(params)
				params.each do |key, _|
					if [:start_date, :end_date].include?(key)
						if params[key].respond_to? :to_s
							params[key] = Chronic.parse(params[key].to_s, context: :past)
						end

						if params[key].respond_to? :strftime
							params[key] = params[key].strftime '%Y-%m-%d'
						end
					end
				end
				params
			end
		end
	end
end
