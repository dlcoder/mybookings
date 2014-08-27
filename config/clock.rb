require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

def execute_rake file, task
  require 'rake'
  rake = Rake::Application.new
  Rake.application = rake
  Rake::Task.define_task(:environment)
  load "#{Rails.root}/lib/tasks/#{file}"
  rake[task].invoke
end

frequency = MYBOOKINGS_CONFIG['extensions_trigger_frequency']

every(frequency.minutes, 'extensions_triggers') do
  execute_rake 'mybookings.rake', 'mybookings:process_about_to_begin_bookings'
  execute_rake 'mybookings.rake', 'mybookings:process_recently_finished_bookings'
end
