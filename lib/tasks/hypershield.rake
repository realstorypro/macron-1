Rake::Task["hypershield:refresh"].clear

namespace :hypershield do
  task refresh: :environment do
    # don't do hypershield if we're testing
    # because we dont want to deal with Heroku
    # todo: remove this once we get off heroku
    unless Rails.env.test?
      $stderr.puts "[hypershield] Refreshing schemas"
      Hypershield.refresh
      $stderr.puts "[hypershield] Success!"
    end
  end
end

Rake::Task["db:migrate"].enhance do
  Rake::Task["hypershield:refresh"].invoke
end

Rake::Task["db:rollback"].enhance do
  Rake::Task["hypershield:refresh"].invoke
end
