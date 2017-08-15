require 'spec_helper'

describe Album, type: :model do
  let(:album) { Album.new }

  describe :validations do
    describe 'on name' do
      it 'validates presence' do
        album.name = ''
        expect(album).not_to be_valid
      end

      it 'validates uniqueness' do
        Album.create name: 'Title'
        album.name = 'Title'
        expect(album).not_to be_valid
      end
    end
  end
end
