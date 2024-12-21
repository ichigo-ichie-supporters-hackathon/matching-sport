class SubgenreController < ApplicationController
  def index
    subgenres = Subgenre.where(genre_id: params[:genre_id])
    render json: { subgenres: subgenres }
  end
end
