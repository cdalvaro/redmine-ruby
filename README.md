# Readmine Ruby Client

```ruby
require 'redmine'

Redmine::Base.configure do
  raise 'URL not found' if ENV['REDMINE_URL'].nil?
  raise 'Token not found' if ENV['REDMINE_API_KEY'].nil?

  self.site = ENV['REDMINE_URL']
  self.token = ENV['REDMINE_API_KEY']
end

user = Redmine::User.find(:first, params: { name: 'carlos.alvaro' })

issues = Redmine::Issue.find(:all, params: { assigned_to_id: user.id, status_id: '*' })
puts issues

```