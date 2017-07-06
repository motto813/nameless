get '/applications' do
  @applications = Application.all

  erb :"applications/index"
end

get '/applications/new' do
  erb :"applications/new"
end

post '/applications' do
  @application = Application.new(params[:application])

  if @application.save
    redirect '/applications'
  else
    erb :"applications/new"
  end
end

get '/applications/:id' do
  @application = Application.find(params[:id])

  erb :"applications/show"
end

get '/applications/:id/edit' do
  @application = Application.find(params[:id])

  erb :"applications/edit"
end


put '/applications/:id' do
  @application = Application.find(params[:id])

  @application.assign_attributes(params[:application])

  if @application.save
    redirect '/applications'
  else
    erb :"applications/edit"
  end
end


delete '/applications/:id' do
  @application = Application.find(params[:id])

  @application.destroy

  redirect '/applications'
end
