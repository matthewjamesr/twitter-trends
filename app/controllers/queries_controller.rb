class QueriesController < ApplicationController
  def index

  end

  def show
    if params[:query] == ""
      redirect_to root_path
      flash[:notice] = "You must enter a search term."
    end
    if params[:query] != ""
      @hashtags = API.hashtags(params[:query])
    end
  end

  def highlight(text, search_string)
    keywords = search_string.squeeze.strip.split(" ").compact.uniq
    matcher = Regexp.new( '(' + keywords.join("|") + ')' )
    highlighted = text.gsub(matcher) { |match| "#{match}" }

    return highlighted
  end
end
