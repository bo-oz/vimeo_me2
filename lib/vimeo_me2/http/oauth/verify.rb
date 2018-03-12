module VimeoMe2
  module Http
    module OAuth
      module Verify

        def check_authorization(type=nil)
          error = "Authorization is required for this action and you have not provided a valid token."
          raise RequestFailed.new(401, 'Unauthorized', error) unless @headers['authorization']
          if type
            error = "The request you are making requires a token with #{type} access,
              the token you have provided does not have that authority."
            raise RequestFailed.new(401, 'Unauthorized', error) unless type.in? get_access_level
          end
        end

        private

          def get_access_level
            @access_level || @access_level = verify_oauth_token
          end

          def verify_oauth_token
            req = make_http_request('get','/oauth/verify?fields=scope')
            return req['scope'].split
          end
      end
    end
  end
end
