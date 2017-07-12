get '/applicants' do
  @applicants = Applicant.all

  erb :"applicants/index"
end

get '/applicants/new' do
  @applicant = Applicant.new

  erb :"applicants/new"
end

post '/applicants' do
  @applicant = Applicant.new(params[:applicant])

  if @applicant.save
    redirect '/looking'
  else
    @errors = @applicant.errors.full_messages

    erb :"applicants/new"
  end
end

get '/applicants/:id' do
  if Applicant.authorized?(session[:user], params[:id])
    @applicant = Applicant.find(params[:id])
    @applications = Application.submitted_by_applicant(params[:id])
    @resumes = Resume.where(applicant: @applicant)

    erb :"applicants/show"
  else
    status 401
    @applicant = Applicant.new
    @errors = @applicant.errors.full_messages
    @errors << "You can't view that applicant's profile"
    erb :hiring
  end
end

get '/applicants/:id/edit' do
  @applicant = Applicant.find(params[:id])

  erb :"applicants/edit"
end


put '/applicants/:id' do
  @applicant = Applicant.find(params[:id])

  @applicant.assign_attributes(params[:applicant])

  if @applicant.save
    redirect '/applicants'
  else
    erb :"applicants/edit"
  end
end


delete '/applicants/:id' do
  @applicant = Applicant.find(params[:id])

  @applicant.destroy

  redirect '/applicants'
end
