module VimeoMe2
  module Http
    module OAuth
      module Verify

        private
          def verify_oauth_token
            req = make_http_request('get','/oauth/verify')
            return req['scope'].split
          end

          def get_access_level
            @access_level || @access_level = verify_oauth_token
          end

          def check_authorization(type=nil)
            error = "Authorization is required for this action and you have not provided a valid token."
            raise RequestFailed, error unless @headers[:authorization]
            if type
              error = "The request you are making requires a token with #{type} access,
                the token you have provided does not have that authority."
              allowed_types = get_access_level
              raise RequestFailed, error unless @headers[:authorization] unless type.in? allowed_types
            end
          end
      end
    end
  end
end
