class CommonQuestionsController < ApplicationController
  def index
    @random_gif = Gif.get_random_gif
  end
    def show
  end
end
