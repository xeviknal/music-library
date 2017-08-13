require 'spec_helper'

describe MusicLibrary::Application do
  let(:application) { MusicLibrary::Application.new }
  subject { application }

  it { is_expected.to respond_to(:call).with(1).argument }

  describe :call do
    subject { application.call([]) }

    before do
      # Expect to call Router
      # Expect to initialize controller with request
      # Expect controller to be called
    end

    describe 'response' do
      it 'is an array of three items' do
        expect(subject.size).to eq 3
      end

      it 'first parameter is HTTP code response' do
        expect(Integer(subject.first)).to be > 0
      end

      it 'second parameter is a hash with header information' do
        expect(subject[1]).to be_instance_of(Hash)
        expect(subject[1]).to include({'Content-Type' => 'application/json'})
      end

      it 'third parameter is a array with the response (String)' do
        expect(subject.last).to be_instance_of(Array)
        expect(subject.last.last).to be_instance_of(String)
      end
    end
  end
end
