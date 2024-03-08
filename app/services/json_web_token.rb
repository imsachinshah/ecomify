require 'jwt'

class JsonWebToken 
	attr_reader :id, :expiration

	class << self
		
		def encode(id, data= {}, expiration=nil)
			expiration, data = data, expiration unless data.is_a?(Hash)
			expiration ||= 24.hours.from_now
			data ||= {}
			payload = build_payload_for(id.to_i, data, expiration.to_i)
			JWT.encode(payload, secret_key, algorithm)
		end

		def decode(token)
			JsonWebToken.new(token_data_for(token))
		end

		private

		def token_data_for(token)
			JWT.decode(token, secret_key, true, {
				algorithm: algorithm
			})[0]
		end

		def build_payload_for(id, data, expiration)
			{
				id: id,
				exp: expiration
			}.merge(data)
		end

		def secret_key
			@secret_key ||= Rails.application.secret_key_base
		end

		def algorithm
			'HS512'
		end
	end
end
	