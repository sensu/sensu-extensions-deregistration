require 'sensu/extension'
require 'net/http'

module Sensu
  module Extension
    class Deregistration < Handler
      def name
        'deregistration'
      end

      def description
        'deregisters (deletes) clients'
      end

      def options
        return @options if @options
        @options = {
          timeout: 1
        }
        @options.merge!(@settings[:deregistration]) if @settings[:deregistration].is_a?(Hash)
        @options
      end

      # Returns configuration for an API
      def api
        return @api if @api
        @api = if @settings[:api].key?(:endpoints) && @settings[:api][:endpoints].is_a?(Array)
                 @settings[:api][:endpoints].sample
               else
                 @settings[:api] || {}
               end
      end

      # Remove the Sensu client from the registry, using the Sensu
      # API. This method returns `true` if the Sensu client deletion
      # was successful.
      #
      # @param event [Hash]
      # @return [TrueClass, FalseClass]
      def remove_sensu_client!(event)
        http = Net::HTTP.new(api_settings.fetch(:host, '127.0.0.1'), api_settings.fetch(:port, 4567))
        client_name = event[:client][:name]
        request = Net::HTTP::Delete.new("/clients/#{client_name}")
        if api[:user] && api[:password]
          request.basic_auth(api[:user], api[:password])
        end
        response = http.request(request)
        response.code == '202'
      end

      def run(event, &callback)
        handle = proc do
          client_name = event[:client][:name]
          begin
            Timeout.timeout(options[:timeout]) do
              if remove_sensu_client!(event)
                ["deleted client #{client_name}", 0]
              else
                ["error deleting client #{client_name}", 2]
              end
            end
          rescue => error
            @logger.error('client deregistration error', error: error.to_s)
            ["error deleting client #{client_name}: #{error}", 2]
          end
        end
        EM.defer(handle, callback)
      end
    end
  end
end
