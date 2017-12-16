class User < ApplicationRecord
    include PastaRails
    has_pasta_password
end
