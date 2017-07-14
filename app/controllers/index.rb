enable :sessions

before do
  if session[:user].instance_of?(Applicant)
    @is_applicant = true
    @applicant = Applicant.find(session[:user].id)
  elsif session[:user].instance_of?(Recruiter)
    @is_recruiter = true
    @recruiter = Applicant.find(session[:user].id)
  end
end

get '/' do
  erb :index, layout: false
end

get '/looking' do
  if @is_applicant
    redirect "/applicants/#{session[:user].id}"
  elsif @is_recruiter
    session.delete(:user)
    session.delete(:message)
  end

  erb :looking
end

post '/looking/login' do
  applicant = Applicant.authenticate(params[:applicant][:email], params[:applicant][:password])
  unless applicant.nil?
    session[:user] = applicant
    session[:message] = "Logged in as #{applicant.first_name} #{applicant.last_name} (Applicant)."
    redirect "/applicants/#{applicant.id}"
  else
    @invalid = "Error: Not a valid email - password combo."
    erb :looking
  end
end

get '/hiring' do
  if @is_applicant
    session.delete(:user)
    session.delete(:message)
  elsif @is_recruiter
    redirect "/recruiters/#{session[:user].id}"
  end

  erb :hiring
end

post '/hiring/login' do
  recruiter = Recruiter.authenticate(params[:recruiter][:email], params[:recruiter][:password])
  unless recruiter.nil?
    session[:user] = recruiter
    session[:message] = "Logged in as #{recruiter.first_name} #{recruiter.last_name}. (Recruiter)"
    redirect "/recruiters/#{recruiter.id}"
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
