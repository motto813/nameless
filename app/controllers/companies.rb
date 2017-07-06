get '/companies' do
  @companies = Company.all

  erb :"companies/index"
end

get '/companies/new' do
  erb :"companies/new"
end

post '/companies' do
  @company = Company.new(params[:company])

  if @company.save
    redirect '/companies'
  else
    erb :"companies/new"
  end
end

get '/companies/:id' do
  @company = Company.find(params[:id])

  erb :"companies/show"
end

get '/companies/:id/edit' do
  @company = Company.find(params[:id])

  erb :"companies/edit"
end


put '/companies/:id' do
  @company = Company.find(params[:id])

  @company.assign_attributes(params[:company])

  if @company.save
    redirect '/companies'
  else
    erb :"companies/edit"
  end
end


delete '/companies/:id' do
  @company = Company.find(params[:id])

  @company.destroy

  redirect '/companies'
end
