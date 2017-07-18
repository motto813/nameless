require 'faker'

# APPLICATIONS

number_of_applicants_wanted = 4
new_applicants_needed = number_of_applicants_wanted - Applicant.count

new_applicants_needed.times do
  applicant = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  applicant[:email] = Faker::Internet.unique.safe_email("#{applicant[:first_name]}.#{applicant[:last_name]}")
  applicant[:password] = "password"
  applicant[:password_confirmation] = "password"

  applicant = Applicant.new(applicant)
  applicant.save!
end

# RECRUITERS

number_of_recruiters_wanted = 4
new_recruiters_needed = number_of_recruiters_wanted - Recruiter.count

new_recruiters_needed.times do
  recruiter = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  recruiter[:email] = Faker::Internet.unique.safe_email("#{recruiter[:first_name]}.#{recruiter[:last_name]}")
  recruiter[:password] = "password"
  recruiter[:password_confirmation] = "password"

  recruiter = Recruiter.new(recruiter)
  recruiter.save!
end

# RESUMES

# number_of_resumes_wanted = 4
# new_resumes_needed = number_of_resumes_wanted - Resume.count

# new_resumes_needed.times do |x|
#   resume = { file_name: Faker::StarWars.planet + ".pdf" }
#   resume = Resume.new(resume)

#   resume.applicant_id = x + 1

#   resume.save!
# end

# COMPANIES

number_of_companies_wanted = 4
new_companies_needed = number_of_companies_wanted - Company.count

new_companies_needed.times do
  company = { name: Faker::Company.name }

  company = Company.new(company)

  company.save!
end

# POSITIONS

number_of_positions_wanted = 4
new_positions_needed = number_of_positions_wanted - Position.count

new_positions_needed.times do |x|
  position = { title: Faker::Job.title, description: Faker::Friends.quote }
  position = Position.new(position)

  position.company_id = x + 1
  position.recruiter_id = x + 1

  position.save!
end

# APPLICATIONS

# number_of_applications_wanted = 4
# new_applications_needed = number_of_applications_wanted - Application.count

# new_applications_needed.times do |x|
#   application = Application.new

#   application.resume_id = x + 1
#   application.position_id = x + 1

#   application.save!
# end
