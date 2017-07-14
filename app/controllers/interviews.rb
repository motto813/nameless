get '/interviews' do
  @interviews = Interview.all

  erb :"interviews/index"
end

# get '/interviews/new' do
#   erb :"interviews/new"
# end

post '/interviews' do
  @interview = Interview.new(params[:interview])

  if @interview.save
    @interview.application.interview_id = @interview.id
    @interview.application.save

    redirect "/interviews/#{@interview.id}"
  else
    @errors = @interview.errors.full_messages
    erb :"hiring"
  end
end

get '/interviews/:id' do
  @interview = Interview.find(params[:id])

  if Applicant.authorized?(session[:user], @interview.applicant_id)
    @authorized_applicant = true

    erb :"interviews/show"
  elsif Recruiter.authorized?(session[:user], @interview.recruiter_id)
    @authorized_recruiter = true

    erb :"interviews/show"
  else
    status 401
    @errors = @interview.errors.full_messages
    @errors << "You can't view that interview"
    erb :looking
  end
end

get '/interviews/:id/edit' do
  @interview = Interview.find(params[:id])

  if Applicant.authorized?(session[:user], @interview.applicant_id)
    erb :"interviews/edit"
  elsif Recruiter.authorized?(session[:user], @interview.recruiter_id)
    status 401
    @errors = @interview.errors.full_messages
    @errors << "You can't edit an interview as a recruiter"
    erb :"interviews/#{@interview.id}"
  else
    status 401
    @errors = @interview.errors.full_messages
    @errors << "You can't view that interview"
    erb :looking
  end
end

put '/interviews/:id' do
  @interview = Interview.find(params[:id])

  @interview.assign_attributes(params[:interview])

  if @interview.save
    redirect "/interviews/#{@interview.id}"
  else
    erb :"interviews/edit"
  end
end

delete '/interviews/:id' do
  @interview = Interview.find(params[:id])

  @interview.destroy

  redirect '/interviews'
end
