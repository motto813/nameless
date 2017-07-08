enable :sessions

before do
  if session[:user].instance_of?(Applicant) && params[:applicant_id].to_i == session[:user].id
    @authorized_applicant = true
  else
    @authorized_applicant = false
  end

  if session[:user].instance_of?(Recruiter) && params[:recruiter_id].to_i == session[:user].id
    @authorized_recruiter = true
  else
    @authorized_recruiter = false
  end
end

get '/' do
  erb :index, layout: false
end

get '/looking' do
  unless session[:user].instance_of? Applicant
    session.delete(:user)
    session.delete(:message)
  end

  erb :looking
end

post '/looking/login' do
  applicant = Applicant.authenticate(params[:applicant][:email], params[:applicant][:password])
  puts params
  unless applicant.nil?
    session[:user] = applicant
    session[:message] = "Logged in as #{applicant.first_name} #{applicant.last_name} (Applicant)."
    redirect '/looking'
  else
    @invalid = "Error: Not a valid email - password combo."
    erb :looking
  end
end

get '/hiring' do
  unless session[:user].instance_of? Recruiter
    session.delete(:user)
    session.delete(:message)
  end

  erb :hiring
end

post '/hiring/login' do
  recruiter = Recruiter.authenticate(params[:recruiter][:email], params[:recruiter][:password])
  puts params
  unless recruiter.nil?
    session[:user] = recruiter
    session[:message] = "Logged in as #{recruiter.first_name} #{recruiter.last_name}. (Recruiter)"
    redirect '/hiring'
  else
    @invalid = "Error: Not a valid email - password combo."
    erb :hiring
  end
end

get '/logout' do
  session.delete(:user)
  session.delete(:message)

  erb :index, layout: false
end
