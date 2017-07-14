# before '/applications' do
#   if @is_applicant

get '/applications' do
  if @authorized_admin
    @applications = Application.all
  elsif @is_applicant
    @applications = Application.submitted_by_applicant(session[:user])
  elsif @is_recruiter
    @applications = Application.submitted_for_position(session[:user])
  end

  erb :"applications/index"
end

# get '/applications/new' do
#   @position = Position.find(params[:position_id])

#   @applicant = Applicant.find(params[:applicant_id])
#   @resumes = @applicant.resumes

#   erb :"applications/new"
# end

post '/applications' do
  @application = Application.new(params[:application])

  if @application.save
    redirect "/applicants/#{@application.resume.applicant.id}"
  else
    erb :"applications/_new"
  end
end

get '/applications/:id' do
  @application = Application.find(params[:id])

  if Applicant.authorized?(session[:user], @application.resume.applicant.id)
    @applicant = session[:user]
    @position = @application.position
    @resume = @application.resume

    if @application.scheduled_for_interview?
      @selected_for_interview = true
      @interview = @application.interview
      @recruiter = @application.interview.recruiter.full_name
    end

    erb :"applications/show"
  else
    if @is_applicant
      redirect '/looking'
    elsif @is_recruiter
      redirect '/hiring'
    else
      redirect '/'
    end
  end
end

# get '/applications/:id/edit' do
#   @application = Application.find(params[:id])

#   erb :"applications/edit"
# end

# put '/applications/:id' do
#   @application = Application.find(params[:id])

#   @application.assign_attributes(params[:application])

#   if @application.save
#     redirect '/applications'
#   else
#     erb :"applications/edit"
#   end
# end


delete '/applications/:id' do
  @application = Application.find(params[:id])

  @application.destroy

  redirect '/applications'
end
