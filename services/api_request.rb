# app/services/omdb_api/api_request.rb

require 'net/http'
require 'json'

##
# Service for processing API requests to OpenWeatherMap
#
class ApiRequest
  API_PATH = 'https://api.openweathermap.org/data/2.5'.freeze

  HEADERS = {
    'Content-Type' => 'application/json'
  }.freeze

  attr_reader :api_path, :api_key

  def initialize
    @api_path = API_PATH
    @api_key = ENV['API_KEY']
  end

  def get(query)
    get_response(query)
  end

  private

  def get_response(query)
    uri = URI(@api_path + query)
    req = Net::HTTP::Get.new(uri.request_uri)
    resp = http_response(req, uri)
    parse_response(resp)
  end

  def http_response(req, uri)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  rescue StandardError => e
    puts 'An error occurred while sending this request'
    handle_error(e)
  end

  # Eval and parse http response
  def parse_response(resp)
    return resp unless resp.respond_to?(:body)

    JSON.parse(resp.body, symbolize_names: true)
  rescue StandardError => e
    puts "Error parsing response from #{api_path}"
    handle_error(e)
  end

  def handle_error(err)
    puts err.message
    puts err.backtrace.join("\n")
    { error: err.message }
  end
end
