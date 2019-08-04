# services\weather.rb

require_relative 'api_request'
require 'ostruct'

# Service for building OpenStruct with weather data
class Weather
  API = ApiRequest.new

  attr_reader :data

  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @city = params[:city]
    @country = params[:country]
  end

  def call
    fetch_weather
  end

  def render
    OpenStruct.new(@data)
  end

  private

  def fetch_weather
    @data = API.get(endpoint)
    self
  end

  def endpoint
    "/weather?q=#{@city},#{@country}&APPID=#{API.api_key}"
  end
end
