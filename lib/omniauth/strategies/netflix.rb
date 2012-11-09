require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Netflix < OmniAuth::Strategies::OAuth
      option :client_options, {
        :site               => 'http://api-public.netflix.com',
        :authorize_url      => 'https://api-user.netflix.com/oauth/login',
        :request_token_url  => 'http://api-public.netflix.com/oauth/request_token',
        :access_token_url   => 'http://api-public.netflix.com/oauth/access_token'
      }

      uid { raw_info['user']['user_id'] }

      info do
      {
        'nickname'    => raw_info['user']['nickname'],
        'first_name'  => raw_info['user']['first_name'],
        'last_name'   => raw_info['user']['last_name'],
        'name'        => "#{raw_info['user']['first_name']} #{raw_info['user']['last_name']}"
      }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      def request_phase
        request_token = consumer.get_request_token(:oauth_callback => callback_url)
        session['oauth'] ||= {}
        session['oauth'][name.to_s] = {'callback_confirmed' => request_token.callback_confirmed?, 'request_token' => request_token.token, 'request_secret' => request_token.secret}

        if request_token.callback_confirmed?
          redirect request_token.authorize_url(options[:authorize_params].merge(:oauth_consumer_key => consumer.key))
        else
          redirect request_token.authorize_url(options[:authorize_params].merge(:oauth_callback => callback_url, :oauth_consumer_key => consumer.key))
        end

      rescue ::Timeout::Error => e
        fail!(:timeout, e)
      rescue ::Net::HTTPFatalError, ::OpenSSL::SSL::SSLError => e
        fail!(:service_unavailable, e)
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get("http://api-public.netflix.com/users/#{@access_token.params[:user_id]}?output=json").body)
      end

    end
  end
end