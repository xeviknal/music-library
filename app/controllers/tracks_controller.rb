class TracksController < BaseController
  def index
    @tracks = if params[:id]
      Track.where(album_id: params[:id])
    else
      Track.all
    end

    render @tracks
  end

  def create
    track = Track.new(params)

    if track.save
      render track
    else
      render track.errors.full_messages, status: 500
    end
  end

  def destroy
    track = Track.find params[:id]

    if track.destroy
      render_success
    else
      render_failure
    end
  end
end
