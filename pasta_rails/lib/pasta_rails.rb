module PastaRails
    extend ActiveSupport::Concern

    require 'libpasta'

    module ClassMethods
      def has_pasta_password(options = {})
        include InstanceMethodsOnActivation
      end

    end

    module InstanceMethodsOnActivation
      def authenticate(unencrypted_password)
        @password_digest = self.password_digest
        res, new_hash = Pasta.verify_password_update_hash(@password_digest, unencrypted_password)
        if res
            # Want to avoid database transaction if possible
            if !new_hash.eql? @password_digest
              self.update password_digest: new_hash
            end
            self
        else
            false
        end
      end

      attr_reader :password

      def password=(unencrypted_password)
        if unencrypted_password.nil?
          self.password_digest = nil
        elsif !unencrypted_password.empty?
          self.password_digest = Pasta.hash_password(unencrypted_password)
        end
      end

      def password_confirmation=(unencrypted_password)
        @password_confirmation = unencrypted_password
      end

    end

end

class MyRailtie < Rails::Railtie
  rake_tasks do
    load 'tasks/pasta_tasks.rake'
  end
end
