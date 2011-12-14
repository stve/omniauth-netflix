require 'spec_helper'

describe OmniAuth::Strategies::Netflix do
  before :each do
    @request = double('Request')
    @request.stub(:params) { {} }
  end

  subject do
    OmniAuth::Strategies::Netflix.new(nil, @options || {}).tap do |strategy|
      strategy.stub(:request) { @request }
    end
  end

  describe '#client_options' do
    it 'has correct Netflix site' do
      subject.options.client_options.site.should eq('http://api.netflix.com')
    end

    it 'has correct authorize url' do
      subject.options.client_options.authorize_url.should eq('https://api-user.netflix.com/oauth/login')
    end

    it 'has correct request token url' do
      subject.options.client_options.request_token_url.should eq('http://api.netflix.com/oauth/request_token')
    end

    it 'has correct access token url' do
      subject.options.client_options.access_token_url.should eq('http://api.netflix.com/oauth/access_token')
    end
  end

  describe '#uid' do
    it 'returns the uid from raw_info' do
      subject.stub(:raw_info) {{ 'user' => { 'user_id' => '123' } } }
      subject.uid.should eq('123')
    end
  end

  describe '#info' do
    before :each do
      @raw_info ||= { 'user' => { 'first_name' => 'Fred', 'last_name' => 'Smith', 'nickname' => 'freddy' } }
      subject.stub(:raw_info) { @raw_info }
    end

    context 'when data is present in raw info' do
      it 'returns the name' do
        subject.info['name'].should eq('Fred Smith')
      end

      it 'returns the first name' do
        subject.info['first_name'].should eq('Fred')
      end

      it 'returns the last name' do
        subject.info['last_name'].should eq('Smith')
      end

      it 'returns the nickname' do
        subject.info['nickname'].should eq('freddy')
      end
    end
  end

  describe '#extra' do
    before :each do
      @raw_info_hash = { "links" => [:link => "http://api.netflix.com/users/T1PambOVJXcoWzNRQEyacp76BnRn0TIJdxKGyklbY0srg-/queues"] }
      subject.stub(:raw_info) { @raw_info_hash }
    end

    it 'returns a Hash' do
      subject.extra.should be_a(Hash)
    end
  end
end