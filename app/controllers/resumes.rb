get '/resumes' do
  if @authorized_admin
    @resumes = Resume.all
  elsif @is_applicant
    @resumes = Resume.where(applicant_id: session[:user].id)
  else
    @resumes = []
  end

  erb :"resumes/index"
end

get '/resumes/new' do

  if @is_applicant
    @applicant = session[:user]
  end

  erb :"resumes/new"
end

post '/resumes' do
  @resume = Resume.new(params[:resume])

  @resume.resume_file = params[:file]

  @resume.file_name = params[:file][:filename]

  if @resume.save
    redirect "/applicants/#{@resume.applicant.id}"
  else
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
