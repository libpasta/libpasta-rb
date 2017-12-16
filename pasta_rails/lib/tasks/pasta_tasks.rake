# desc "Explaining what the task does"
# task :pasta do
#   # Task goes here
# end

namespace :pasta do
    desc "Updates all passwords to the recommended password algorithm"
    task migrate_passwords: :environment do
        User.all.each do |user|
            user.password_digest = Pasta.migrate_hash(user.password_digest)
            user.save
        end
    end
end
