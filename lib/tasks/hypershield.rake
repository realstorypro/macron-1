namespace :hypershield do
  task refresh: :environment do
    # don't do hypershield if we're testing
    return true if Rails.env.test?

    $stderr.puts "[hypershield] Refreshing schemas"
    Hypershield.refresh
    $stderr.puts "[hypershield] Success!"
  end
end

Rake::Task["db:migrate"].enhance do
  Rake::Task["hypershield:refresh"].invoke
end

Rake::Task["db:rollback"].enhance do
  Rake::Task["hypershield:refresh"].invoke
end
