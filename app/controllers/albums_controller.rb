class AlbumsController < BaseController
  def index
    render Album.all
  end
end
