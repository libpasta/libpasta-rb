module PastaRails
    extend ActiveSupport::Concern

    require 'libpasta'

    module ClassMethods
      def has_pasta_password(options = {})
        include InstanceMethodsOnActivation

        include ActiveModel::Validations

        # This ensures the model has a password by checking whether the password_digest
        # is present, so that this works with both new and existing records. However,
        # when there is an error, the message is added to the password attribute instead
        # so that the error message will make sense to the end-user.
        validate do |record|
          record.errors.add(:password, :blank) unless record.password_digest.present?
        end

        validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
        validates_confirmation_of :password, allow_blank: true
      end

    end

    module InstanceMethodsOnActivation
      def authenticate(unencrypted_password)
        @password_digest = self.password_digest
        res = Pasta.verify_password_update_hash(@password_digest, unencrypted_password)

        case res.tag
        when Pasta::HashUpdate::Updated
            self.password_digest = res.updated
            return true
        when  Pasta::HashUpdate::Ok
            return true
        else
            return false
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
