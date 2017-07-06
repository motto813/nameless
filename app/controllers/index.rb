get '/' do
  erb :index
end

get '/looking' do
  erb :looking
end

post '/looking/login' do
  # see user registration DBC challenge
end

get '/hiring' do
  erb :hiring
end

post '/hiring/login' do
  # see user registration DBC challenge
end
