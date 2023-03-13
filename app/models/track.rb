class Track < ApplicationRecord

  def index
    render json: { foo: 'bar' }
  end

end
