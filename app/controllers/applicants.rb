get '/applicants' do
  @applicants = Application.all
  erb :"applicants/index"
end
