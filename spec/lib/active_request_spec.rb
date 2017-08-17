require 'spec_helper'

describe ActiveRequest do
  subject { request }
  let(:request) { ActiveRequest.new(environment) }

  describe '.params' do
    subject { request.params }

    context 'when there is no params' do
      let(:environment) { {'QUERY_STRING': ''} }

      it { is_expected.to eq Hash.new }
    end

    context 'when there are params' do
      let(:environment) { {'QUERY_STRING': 'param1=2&param2=1'} }

      it 'has param1 with 2 as a value' do
        expect(subject[:param1]).to eq 2
      end

      it 'has param2 with 1 as a value' do
        expect(subject[:param2]).to eq 1
      end

      it 'can be accessed by string or symbols' do
        expect(subject).to be_instance_of(ActiveSupport::HashWithIndifferentAccess)
      end
    end

    context 'when there are params in body' do
      let(:environment) { {'rack.input': body } }
      let(:body) { StringIO.new('{"name": "Elliot"}') }

      it 'has name with Elliot as a value' do
        expect(subject[:name]).to eq 'Elliot'
      end

      it 'can be accessed by string or symbols' do
        expect(subject).to be_instance_of(ActiveSupport::HashWithIndifferentAccess)
      end
    end
  end

  describe '.method' do
    subject { request.method }

    %w{GET POST PUT DELETE PATCH}.each do |method|
      context "when request is held via #{method}" do
        let(:environment) { { 'REQUEST_METHOD': method } }

        it { is_expected.to eq method.downcase.to_sym }
      end
    end
  end

  describe '.path' do
    subject { request.path }

    let(:environment) { { "PATH_INFO": '/an/example/path' } }

    it { is_expected.to eq '/an/example/path' }
  end

  describe '.preflight?' do
    subject { request.preflight? }

    context 'when request method is OPTIONS' do
      let(:environment) { { 'REQUEST_METHOD': 'OPTIONS' } }
      it { is_expected.to eq true }
    end

    context 'when request method is not OPTIONS' do
      let(:environment) { { 'REQUEST_METHOD': 'DELETE' } }
      it { is_expected.to eq false }
    end
  end
end
