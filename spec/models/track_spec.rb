require 'spec_helper'

describe Track, type: :model do
  let(:track) { Track.new }

  describe :validations do
    describe 'on name' do
      it 'validates presence' do
        track.name = ''
        expect(track).not_to be_valid
      end

      it 'validates uniqueness' do
        Track.create name: 'Title'
        track.name = 'Title'
        expect(track).not_to be_valid
      end
    end
  end
end
