class PackagesController < ApplicationController

  def index
    free_text = params[:free_text]

    @packages = Package.by_free_text(free_text)
  end

  def show
    @package = Package.includes(:versions).find(params[:id])
  end
end
