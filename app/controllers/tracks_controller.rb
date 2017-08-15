class TracksController < BaseController
  def index
    render Track.all
  end

  def create
    track = Track.new(params)

    if track.save
      render_success
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
