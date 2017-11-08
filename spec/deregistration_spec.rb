require File.join(File.dirname(__FILE__), "helpers")
require "sensu/extensions/deregistration"
require "webmock/rspec"

describe "Sensu::Extension::Deregistration" do
  include Helpers

  before do
    @extension = Sensu::Extension::Deregistration.new
    @extension.logger = Sensu::Logger.get(:log_level => :fatal)
    @extension.settings = {}
  end

  it "can run" do
    async_wrapper do
      stub_request(:delete, "http://127.0.0.1:4567/clients/#{client_template[:name]}").to_return(:status => 202)
      @extension.safe_run(event_template) do |output, status|
        puts output.inspect
        expect(output).to eq("deleted client #{client_template[:name]}")
        expect(status).to eq(0)
        async_done
      end
    end
  end
end
