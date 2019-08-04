# app/services/omdb_api/api_request.rb

require 'uri'
require 'net/http'
require 'json'

##
# Service for processing API requests to OMDB
#
class ApiRequest
  API_KEY = ENV['API_KEY']

  API_PATH = 'https://api.openweathermap.org/data/2.5'.freeze

  HEADERS = {
    'Content-Type' => 'application/json'
  }.freeze

  attr_reader :api_path, :api_key

  def initialize
    @api_path = API_PATH
    @api_key = API_KEY
  end

  def get(query)
    @url = URI(@api_path + query)
    request = get_request
    response = send_request(request)
    parse_response(response)
  end

  protected

  def hostname
    @url.hostname
  end

  def port
    @url.port
  end

  private

  def get_request
    Net::HTTP::Get.new(@url, HEADERS)
  end

  def send_request(request)
    # Net::HTTP.start(hostname, port, use_ssl: true) do |http|
    #   http.request(request)
    # end
    Net::HTTP.start(hostname, port, use_ssl: true) do |http|
      http.request(request)
    end
  rescue StandardError => e
    puts 'An error occurred while sending this request'
    handle_error(e)
  end

  # Eval and parse http response
  def parse_response(response)
    return response unless response.respond_to?(:body)

    JSON.parse(response.body, symbolize_names: true)
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
