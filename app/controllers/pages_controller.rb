class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @books = Book.all.limit 50
    @categories = Category.all
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end
end
