class Api::V1::TracksController < ApplicationController
  def index
    render json: { foo: 'bar' }
  end
end
