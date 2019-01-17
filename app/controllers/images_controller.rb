class ImagesController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        query = (params[:q] || "")
        params[:page] ||= 1
        params[:per_page] ||= 60

        images = Image.search("#{query}*").limit(params[:per_page]).page(params[:page]).results
        render json: {
          q:            query,
          total:        images.total,
          page:         params[:page],
          per_page:     params[:per_page],
          images:       images.map { |image|
            {
              id:               image.id[0..12],
              origin:           image.origin,
              full:             image.url,
              thumbnail:        image.thumbnail,
              tags:             image.tags
            }
          }
        }
      end
    end
  end

  def show
    respond_to do |format|
      format.html { render 'images/index' }
      format.json do
        image = Image.search("_id:#{params[:id]}*").page(1).per(1).first
        render json: {
          id:               image.id[0..12],
          origin:           image.origin,
          full:             image.url,
          thumbnail:        image.thumbnail,
          tags:             image.tags
        }
      end
    end
  end

end
