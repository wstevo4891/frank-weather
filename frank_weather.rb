#!/bin/ruby

require_relative 'env'

require 'sinatra'
require 'sinatra/reloader'

get '/' do
  'Welcome to Frank Weather'
end
