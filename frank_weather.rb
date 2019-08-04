#!/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'json'
require 'cgi'

require_relative 'env'
require './services/weather'

# Load Images
# Dir['./images/*.jpg'].each { |file| require file }

set :raise_errors, true
set :show_exceptions, false
set :message, false

get '/' do
  if params[:city] && params[:country]
    redirect "/weather/#{CGI.escape(params[:city])}/#{params[:country]}"
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

error do
  settings.message = true
  redirect '/'
end
