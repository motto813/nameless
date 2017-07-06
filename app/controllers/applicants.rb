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
    redirect '/applicants'
  else
    erb :"applicants/new"
  end
end

get '/applicants/:id' do
  @applicant = Applicant.find(params[:id])

  erb :"applicants/show"
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
