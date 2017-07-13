get '/positions' do
  @positions = Position.joins(:company).merge(Company.order(:name))

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
    redirect "/recruiters/#{@position.recruiter.id}"
  else
    @companies = Company.all
    @recruiters = Recruiter.all

    @errors = @position.errors.full_messages
    erb :"positions/new"
  end
end

get '/positions/:id' do

  session.each_entry { |entry| puts entry }

  @position = Position.find(params[:id])

  @applicant_id = session[:user].id if @is_applicant
  @applicant_has_applied = @position.is_applied_to_by_applicant?(Applicant.find(@applicant_id))

  @authorized_recruiter = Recruiter.authorized?(session[:user], @position.recruiter_id)

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
    redirect "/positions/#{@position.id}"
  else
    erb :"positions/edit"
  end
end


delete '/positions/:id' do
  @position = Position.find(params[:id])

  @position.destroy

  redirect '/positions'
end
