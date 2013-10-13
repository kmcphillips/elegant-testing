require "spec_helper"

describe HashService do
  let(:hash_service){ HashService.new }
  let(:md5){ "ea702ba4205cb37a88cc84851690a7a5" }
  let(:response_hash){ {"md5" => md5} }

  describe "#md5" do
    context "real web" do
      before(:all) do
        WebMock.allow_net_connect!
      end

      after(:all) do
        WebMock.disable_net_connect!
      end

      it "should get the implementation from the real web" do
        expect(hash_service.md5("pie")).to eq(md5)
      end
    end

    context "HTTParty" do
      it "should mock out the library as expected" do
        HTTParty.should_receive(:get).with("http://md5.jsontest.com/.json?text=pie").and_return(response_hash)
        expect(hash_service.md5_httparty("pie")).to eq(md5)
      end
    end

    context "Faraday" do
      let(:connection){ double }
      let(:config){ double }

      it "should mock out the library as expected" do
        Faraday.should_receive(:new).with(url: 'http://md5.jsontest.com').and_yield(config).and_return(connection)
        config.should_receive(:response).with(:json)
        config.should_receive(:adapter).with(Faraday.default_adapter)
        connection.should_receive(:get).with("/.json", text: "pie").and_return(double(body: response_hash))
        expect(hash_service.md5_faraday("pie")).to eq(md5)
      end
    end

    context "webmock" do
      it "should be not care about the HTTP library implementation" do
        stub_request(:get, 'md5.jsontest.com/.json?text=pie')
          .to_return(body: response_hash.to_json, headers: {'Content-Type' => 'application/json'})

        expect(hash_service.md5_faraday("pie")).to eq(md5)
        expect(hash_service.md5_httparty("pie")).to eq(md5)
      end
    end
  end
end
