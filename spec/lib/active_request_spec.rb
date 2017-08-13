require 'spec_helper'

describe ActiveRequest do
  subject { request }
  let(:request) { ActiveRequest.new(environment) }

  describe '.params' do
    subject { request.params }

    context 'when there is no params' do
      let(:environment) { {'query_string': ''} }

      it { is_expected.to eq Hash.new }
    end

    context 'when there are params' do
      let(:environment) { {'query_string': 'param1=2&param2=1'} }

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
end
