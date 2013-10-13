require "spec_helper"

describe HashService do
  let(:hash_service){ HashService.new }
  let(:md5){ "ea702ba4205cb37a88cc84851690a7a5" }
  let(:response_hash){ {"md5" => md5} }

  describe "#md5" do
    it "should get the implementation from the real web" do
      expect(hash_service.md5("pie")).to eq(md5)
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

    context "fakeweb" do
      it "should be tested" do
        pending
      end
    end
  end
end
