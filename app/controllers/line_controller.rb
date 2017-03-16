class LineController < ApplicationController
  def show
    line = Line.new(params[:id])
    if line.exist?
      render json: {
        status: 200,
        text: line.text
      }
    else
      render json: {
        status: 413
      }
    end
  end
end
