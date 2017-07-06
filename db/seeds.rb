require 'faker'

number_of_applicants_wanted = 4

new_applicants_needed = number_of_applicants_wanted - Applicant.count

new_applicants_needed.times do
  applicant = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  applicant[:email] = Faker::Internet.unique.safe_email("#{applicant[:first_name]}.#{applicant[:last_name]}")
  applicant[:password] = "password"

  applicant = User.new(applicant)
  applicant.save!
end

number_of_recruiters_wanted = 4

new_recruiters_needed = number_of_recruiters_wanted - Recruiter.count

new_recruiters_needed.times do
  recruiter = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  recruiter[:email] = Faker::Internet.unique.safe_email("#{applicant[:first_name]}.#{applicant[:last_name]}")
  recruiter[:password] = "password"

  recruiter = Recruiter.new(recruiter)
  recruiter.save!
end

number_of_resumes_wanted = 4

new_resumes_needed = number_of_resumes_wanted - Resume.count

new_resumes_needed.times do
  resume = { file_location}
end
