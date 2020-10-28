require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Sevengeese < OmniAuth::Strategies::OAuth2
      option :name, "sevengeese"

      option :client_options, {
        :site => "https://app.7geese.com",
        authorize_url: "/o/authorize",
        token_url: "/o/token"
      }

      option :pkce, true

      uid {
        raw_info['data']['currentUser']['pk']
      }

      info do
        {
          :name => raw_info['data']['currentUser']['fullName'],
          :email => raw_info['data']['currentUser']['user']['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/graphql?query={currentUser{pk%0AfullName%0Auser{email}}}').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def authorize_params
        super.tap do |params|
          options[:authorize_options].each do |k|
            params[k] = request.params[k.to_s] unless [nil, ''].include?(request.params[k.to_s])
          end

          params[:scope] = "userprofile:read"
        end
      end
    end
  end
end
