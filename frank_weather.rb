#!/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'

require_relative 'env'
require './services/weather'

get '/' do
  erb :index
end

get '/frank/:name' do
  erb :name, locals: params
end

get '/weather/:city/:country' do
  @data = Weather.call(params).render

  erb :weather
end

get '/weather-data/:city/:country' do
  response.headers['Content-Type'] = 'application/json'

  data = Weather.call(params).data

  JSON.pretty_generate(data)
end
