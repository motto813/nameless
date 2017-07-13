get '/interviews' do
  @interviews = Interview.all

  erb :"interviews/index"
end

# get '/interviews/new' do
#   erb :"interviews/new"
# end

post '/interviews' do
  @interview = Interview.new(params[:interview])

  if @interview.save
    redirect "/interviews/#{@interview.id}"
  else
    erb :"interviews/new"
  end
end

get '/interviews/:id' do
  @interview = Interview.find(params[:id])

  erb :"interviews/show"
end

get '/interviews/:id/edit' do
  @interview = Interview.find(params[:id])

  erb :"interviews/edit"
end

put '/interviews/:id' do
  @interview = Interview.find(params[:id])

  @interview.assign_attributes(params[:interview])

  if @interview.save
    redirect "/interviews/#{@interview.id}"
  else
    erb :"interviews/edit"
  end
end

delete '/interviews/:id' do
  @interview = Interview.find(params[:id])

  @interview.destroy

  redirect '/interviews'
end
