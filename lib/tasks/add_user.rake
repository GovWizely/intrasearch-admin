namespace :intrasearch_admin do
  desc 'add intrasearch admin user'
  task :add_user, [:emails] => :environment do |_t, args|
    emails = args[:emails].split(',').map(&:squish)
    emails.each do |email|
      User.create email: email
    end
  end
end
