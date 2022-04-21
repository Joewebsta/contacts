require 'sinatra'
require 'tilt/erubis'
require 'sinatra/content_for'
require 'bundler/setup'
require File.join(File.dirname(__FILE__), 'environment')

configure do
  enable :sessions
  set :session_secret, 'secret'
end

configure(:development) do
  require 'sinatra/reloader'
end

before do
  # session[:contacts] ||= []

  session[:contacts] = [
    { name: 'Joe',
      phone_number: '555-555-5555',
      email_address: 'joe@email.com' },
    { name: 'Scott',
      phone_number: '555-555-5555',
      email_address: 'joe@email.com' }
  ]
end

helpers do
  # add your helpers here
end

# index page
get '/' do
  @contacts = session[:contacts]
  erb :index
end
