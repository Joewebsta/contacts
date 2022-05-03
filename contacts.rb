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
  name = params[:name].strip
  email = params[:email]
  tel = params[:tel]

  errors = validate(name, email, tel)

  if errors.empty?
    session[:contacts] << { name: name, email: email, tel: tel }
    session[:success] = 'Contact added!'
    redirect '/contacts'
  else
    session[:errors] = errors
    erb :new_contact
  end
end

def validate(name, email, tel)
  error_msgs = []
  tel_pattern = /[0-9]{3}-[0-9]{3}-[0-9]{4}/

  error_msgs << 'You must provide a name.' unless name.size.positive?
  error_msgs << 'You must provide a valid email address.' unless email =~ /^.+@.+$/
  error_msgs << 'You must provide a valid telephone number (xxx-xxx-xxxx).' unless tel =~ tel_pattern

  error_msgs
end

helpers do
  # add your helpers here
end
