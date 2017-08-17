require 'spec_helper'

describe Response do
  let(:response) { Response.new }
  subject { response }

  it { is_expected.to respond_to(:body) }
  it { is_expected.to respond_to(:status_code) }
  it { is_expected.to respond_to(:header) }

  describe '.to_rack' do
    subject { response.to_rack }

    before do
      response.status_code = 200
      response.body        = '{"id": 1}'
    end

    it 'is a 3 item array' do
      expect(subject.size).to eq 3
    end

    it 'first item is a string with status code' do
      expect(Integer(subject.first)).to be > 0
    end

    it 'second item is a hash with header information' do
      expect(subject[1]).to be_instance_of(Hash)
    end

    it 'third item is an array with body' do
      expect(subject.last).to be_instance_of(Array)
      expect(subject.last.last).to be_instance_of(String)
    end
  end

  describe '.not_found' do
    subject { Response.not_found }

    it 'status_code is 404' do
      expect(subject.status_code).to eq 404
    end

    it 'header is a hash with content-type as html' do
      expect(subject.header).to eq({ 'Content-Type' => 'text/html',
        "Access-Control-Allow-Origin"=>"*", "Access-Control-Request-Method"=>"*" })
    end

    it 'body is a string html formatted' do
      expect(subject.body).to start_with '<html>'
    end
  end

  describe '.empty' do
    subject { Response.empty }

    it 'status_code is 501' do
      expect(subject.status_code).to eq 501
    end

    it 'header is a hash with content-type as html' do
      expect(subject.header).to eq({ 'Content-Type' => 'text/html',
        "Access-Control-Allow-Origin"=>"*", "Access-Control-Request-Method"=>"*" })
    end

    it 'body is a string html formatted' do
      expect(subject.body).to start_with '<html>'
    end
  end

  describe '.success' do
    subject { Response.success }

    it 'status_code is 200' do
      expect(subject.status_code).to eq 200
    end

    it 'header is a hash with content-type as json' do
      expect(subject.header).to eq({ 'Content-Type' => 'application/json',
        "Access-Control-Allow-Origin"=>"*", "Access-Control-Request-Method"=>"*" })
    end

    it 'body is an empty string' do
      expect(subject.body).to eq ''
    end
  end

  describe '.failure' do
    subject { Response.failure }

    it 'status_code is 500' do
      expect(subject.status_code).to eq 500
    end

    it 'header is a hash with content-type as json' do
      expect(subject.header).to eq({ 'Content-Type' => 'application/json',
        "Access-Control-Allow-Origin"=>"*", "Access-Control-Request-Method"=>"*" })
    end

    it 'body is an empty string' do
      expect(subject.body).to eq ''
    end
  end

  describe '.preflight' do
    subject { Response.preflight }

    it 'status_code is 200' do
      expect(subject.status_code).to eq 200
    end

    it 'header is a hash with content-type as json' do
      expect(subject.header).to eq({
        'Content-Type' => 'application/json',
        'Access-Control-Allow-Origin'=>'*',
        'Access-Control-Request-Method'=>'*',
        'Access-Control-Allow-Methods' => 'POST, GET, DELETE',
        'Access-Control-Allow-Headers' => 'Content-Type, Access-Control-Allow-Headers, Access-Control-Allow-Methods, Authorization, X-Requested-With'
      })
    end

    it 'body is an empty string' do
      expect(subject.body).to eq ''
    end
  end
end
