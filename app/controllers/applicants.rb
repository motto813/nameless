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
  @applicant = Applicant.select("id", "first_name", "last_name", "email").find(params[:id])

  if Applicant.authorized?(session[:user], params[:id])
    @authorized_applicant = true
    @applicant = Applicant.find(params[:id])
    @applications = Application.submitted_by_applicant(@applicant)
    @resumes = Resume.uploaded_by_applicant(@applicant)

    erb :"applicants/show"
  elsif @is_recruiter && Interview.have_a_common_interview?(@applicant.id, session[:user].id)
    @applicant = Applicant.select("first_name", "last_name", "email").find(params[:id])

    erb :"applicants/show"

  else
    status 401
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
