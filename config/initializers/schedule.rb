require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.cron '30 23 * * *' do
  Request.invalid_next_day_requests
end