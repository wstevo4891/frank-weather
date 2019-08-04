#!/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'uri'

require_relative 'env'
require './services/weather'

set :raise_errors, true
set :show_exceptions, false
set :message, false

get '/' do
  if params[:city] && params[:country]
    redirect "/weather/#{params[:city]}/#{params[:country]}"
  end

  erb :index, locals: { message: settings.message }
end

get '/weather/:city/:country' do
  @data = Weather.call(params).render

  if @data.cod == '404'
    puts @data.message
    settings.message = true
    redirect '/'
  else
    settings.message = false
    erb :weather
  end
end

get '/weather-data/:city/:country' do
  response.headers['Content-Type'] = 'application/json'

  data = Weather.call(params).data

  JSON.pretty_generate(data)
end
