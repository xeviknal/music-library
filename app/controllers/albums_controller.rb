class AlbumsController < BaseController
  def index
    render Album.all
  end

  def destroy
    @album = Album.find params[:id]

    if @album.destroy
      render_success
    else
      render_failure
    end
  end
end
