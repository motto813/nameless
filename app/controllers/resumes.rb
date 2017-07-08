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

  erb :"resumes/new"
end

post '/resumes' do
  @Resume = Resume.new(params[:Resume])

  if @Resume.save
    redirect '/resumes'
  else
    @companies = Company.all
    @recruiters = Recruiter.all

    @errors = @Resume.errors.full_messages
    erb :"resumes/new"
  end
end

get '/resumes/:id' do
  @Resume = Resume.find(params[:id])

  erb :"resumes/show"
end

get '/resumes/:id/edit' do
  @Resume = Resume.find(params[:id])

  erb :"resumes/edit"
end


put '/resumes/:id' do
  @Resume = Resume.find(params[:id])

  @Resume.assign_attributes(params[:Resume])

  if @Resume.save
    redirect '/resumes'
  else
    erb :"resumes/edit"
  end
end


delete '/resumes/:id' do
  @Resume = Resume.find(params[:id])

  @Resume.destroy

  redirect '/resumes'
end
