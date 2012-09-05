set :sessions, true

helpers do
  include ERB::Util
  alias_method :h, :html_escape
end

def callback_url
  'http://localhost:9292/callback'
end

def oauth_consumer
  OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, site: 'https://twitter.com')
end

get '/' do
  redirect '/login' unless session[:user]

  Twitter.configure do |config|
    config.consumer_key = CONSUMER_KEY
    config.consumer_secret = CONSUMER_SECRET
    config.oauth_token = session[:user].twitter_access_token
    config.oauth_token_secret = session[:user].twitter_access_token_secret
  end

  twitter = Twitter::Client.new
  @tweets = twitter.home_timeline

  erb :index
end

get '/login' do
  erb :login
end

get '/redirect' do
  oauth = oauth_consumer

  request_token = oauth.get_request_token(oauth_callback: callback_url)

  session[:oauth_token] = request_token.token
  session[:oauth_token_secret] = request_token.secret

  url = request_token.authorize_url

  redirect url
end

get '/callback' do
  oauth = oauth_consumer

  request_token = OAuth::RequestToken.new(
    oauth,
    session[:oauth_token],
    session[:oauth_token_secret])

  access_token = request_token.get_access_token(
    oauth_token: params[:oauth_token],
    oauth_verifier: params[:oauth_verifier])

  Twitter.configure do |config|
    config.consumer_key = CONSUMER_KEY
    config.consumer_secret = CONSUMER_SECRET
    config.oauth_token = access_token.token
    config.oauth_token_secret = access_token.secret
  end

  twitter = Twitter::Client.new

  user = User.find_by_twitter_user_id(twitter.user.id)

  if (user == nil)
    user = User.create do |u|
      u.twitter_user_id = twitter.user.id
      u.twitter_screen_name = twitter.user.screen_name
      u.twitter_profile_image_url = twitter.user.profile_image_url
      u.twitter_access_token = access_token.token
      u.twitter_access_token_secret = access_token.secret
    end
  end

  request.session_options[:renew] = true

  session[:user] = user

  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end
