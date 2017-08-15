class AlbumsController < BaseController
  def index
    render Album.all
  end

  def create
    album = Album.new(params)

    if album.save
      render_success
    else
      render album.errors.full_messages, status: 500
    end
  end

  def destroy
    album = Album.find params[:id]

    if album.destroy
      render_success
    else
      render_failure
    end
  end
end
