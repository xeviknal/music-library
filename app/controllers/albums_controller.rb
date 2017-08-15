class AlbumsController < BaseController
  def index
    render([{ a: 1, b: 2, c: 3 }, 2, 3])
  end
end
