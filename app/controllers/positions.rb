get '/positions' do
  @positions = Position.all

  erb :"positions/index"
end

get '/positions/new' do
  @position = Position.new

  @companies = Company.all
  @recruiters = Recruiter.all

  erb :"positions/new"
end

post '/positions' do
  @position = Position.new(params[:position])
  @position.recruiter = session[:user]

  if @position.save
    redirect '/positions'
  else
    @companies = Company.all
    @recruiters = Recruiter.all

    @errors = @position.errors.full_messages
    erb :"positions/new"
  end
end

get '/positions/:id' do
  @position = Position.find(params[:id])

  erb :"positions/show"
end

get '/positions/:id/edit' do
  @position = Position.find(params[:id])

  @companies = Company.all
  @recruiters = Recruiter.all

  erb :"positions/edit"
end


put '/positions/:id' do
  @position = Position.find(params[:id])

  @position.assign_attributes(params[:position])

  if @position.save
    redirect '/positions'
  else
    erb :"positions/edit"
  end
end


delete '/positions/:id' do
  @position = Position.find(params[:id])

  @position.destroy

  redirect '/positions'
end
