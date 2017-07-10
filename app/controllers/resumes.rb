get '/resumes' do
  if @authorized_applicant
    @resumes = Resume.where(applicant_id: params[:applicant_id])
  else
    @resumes = Resume.all
  end

  erb :"resumes/index"
end

get '/resumes/new' do
  @companies = Company.all
  @recruiters = Recruiter.all

  if session[:user].instance_of? Applicant
    @applicant = session[:user]
  end

  erb :"resumes/new"
end

post '/resumes' do
  @resume = Resume.new(params[:Resume])

  if @resume.save
    redirect '/resumes'
  else
    @companies = Company.all
    @recruiters = Recruiter.all

    @errors = @resume.errors.full_messages
    erb :"resumes/new"
  end
end

get '/resumes/:id' do
  @resume = Resume.find(params[:id])

  erb :"resumes/show"
end

get '/resumes/:id/edit' do
  @resume = Resume.find(params[:id])

  erb :"resumes/edit"
end


put '/resumes/:id' do
  @resume = Resume.find(params[:id])

  @resume.assign_attributes(params[:Resume])

  if @resume.save
    redirect '/resumes'
  else
    erb :"resumes/edit"
  end
end


delete '/resumes/:id' do
  @resume = Resume.find(params[:id])

  @resume.destroy

  redirect '/resumes'
end

get '/resumes/download/:file_name' do |file_name|
  resume = Resume.find_by(file_name: file_name)
  unless resume.nil?
    file = resume.resume_file.current_path
    send_file(file, disposition: 'attachment', filename: resume.file_name)
    redirect '/resumes'
  else
    redirect '/resumes'
  end
end
