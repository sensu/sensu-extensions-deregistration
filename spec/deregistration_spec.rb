require File.join(File.dirname(__FILE__), 'helpers')
require 'sensu/extensions/deregistration'
require 'webmock/rspec'

describe 'Sensu::Extension::Deregistration' do
  include Helpers

  before do
    @extension = Sensu::Extension::Deregistration.new
    @extension.logger = Sensu::Logger.get(log_level: :fatal)
  end

  context 'with api defaults' do
    before do
      @extension.settings = {}
      stub_request(
        :delete, "http://127.0.0.1:4567/clients/#{client_template[:name]}"
      ).to_return(status: 202)
    end

    it 'can delete a client' do
      async_wrapper do
        @extension.safe_run(Sensu::JSON.dump(event_template)) do |output, status|
          puts output.inspect
          expect(output).to eq("deleted client #{client_template[:name]}")
          expect(status).to eq(0)
          async_done
        end
      end
    end
  end

  context 'with api host and port specified' do
    before do
      @extension.settings = { api: { host: '10.0.0.1', port: 7654 } }
      stub_request(
        :delete, "http://10.0.0.1:7654/clients/#{client_template[:name]}"
      ).to_return(status: 202)
    end
    it 'can delete a client' do
      async_wrapper do
        @extension.safe_run(Sensu::JSON.dump(event_template)) do |output, status|
          puts output.inspect
          expect(output).to eq("deleted client #{client_template[:name]}")
          expect(status).to eq(0)
          async_done
        end
      end
    end
  end

  context 'with api endpoints specified' do
    before do
      @extension.settings = {
        api: { endpoints: [{ host: '10.0.0.2', port: 3005 }] }
      }
      stub_request(
        :delete, "http://10.0.0.2:3005/clients/#{client_template[:name]}"
      ).to_return(status: 202)
    end
    it 'can delete a client' do
      async_wrapper do
        @extension.safe_run(Sensu::JSON.dump(event_template)) do |output, status|
          puts output.inspect
          expect(output).to eq("deleted client #{client_template[:name]}")
          expect(status).to eq(0)
          async_done
        end
      end
    end
  end
end
