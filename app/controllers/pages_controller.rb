class PagesController < ApplicationController
  def permalink
    def permalink
      @page = Page.find_by(permalink: params[:permalink])
    end
  end
end
