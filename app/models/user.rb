require 'net/http'
require 'net/https'

class PreferencesValidator < ActiveModel::Validator
    def validate(record)
        if record.user_meta.none? { |m| m.meta_key == "preferences" && m.meta_value != "" }
            record.errors.add :base, "Select at least one preference"
        end
    end
end

class MailValidator < ActiveModel::Validator
    def validate(record)
        uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=e45f3d27e89e4e6eb76919eac0e6f37c&email=#{record.email}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        request =  Net::HTTP::Get.new(uri)
        response = http.request(request)
        json = JSON.parse(response.body)

        if json['quality_score'].to_f < 0.7
            record.errors.add :base, "Provided email is not valid"
        end
    end
end

class User < ApplicationRecord
    has_many :user_meta
    validates :email, presence: true, uniqueness: true
    validates_with PreferencesValidator
    validates_with MailValidator
end
