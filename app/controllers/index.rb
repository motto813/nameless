enable :sessions

get '/' do
  erb :index
end

get '/looking' do
  erb :looking
end

post '/looking/login' do
  applicant = Applicant.authenticate(params[:applicant][:email], params[:applicant][:password])
  puts params
  unless applicant.nil?
    session[:user] = applicant
    session[:message] = "Logged in as #{applicant.first_name} #{applicant.last_name}."
    redirect '/looking'
  else
    @invalid = "Error: Not a valid email - password combo."
    erb :looking
  end
end

get '/hiring' do
  erb :hiring
end

post '/hiring/login' do
  # see user registration DBC challenge
end

get '/logout' do
  session.delete(:user)
  session.delete(:message)

  session.each_entry do |entry|
    puts entry
  end

  erb :index
end
