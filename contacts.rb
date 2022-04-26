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
  session[:contacts] ||= []
end

# index page
get '/' do
  redirect '/contacts'
end

get '/contacts' do
  @contacts = session[:contacts]
  erb :contact
end

get '/contacts/new' do
  erb :new_contact
end

post '/contacts' do
  name = params[:name]
  email = params[:email]
  tel = params[:tel]
  @error_msg = 'You must provide a name.'

  # if true
  #   redirect '/contacts'
  # else
  session[:contacts] << { name: name, email: email, tel: tel }
  session[:success] = 'Contact added!'
  redirect '/contacts'
  # end
end

helpers do
  # add your helpers here
end
# if error
# Display banner with appropriate message
# Redirect to 'contacts/new'
# Populate info that had previously been provided
# Else
# Add new contact hash to session
#

# name validation
# Empty strings
# String must be greater than 0 chars and less than 100 chars
# remove spaces before and after
# email validation
# Must conform to standard email regex
# telephone validation
#
