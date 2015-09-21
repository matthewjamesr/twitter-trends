class QueriesController < ApplicationController
  def index

  end

  def show
    if params[:query] == ""
      redirect_to root_path
      flash[:notice] = "You must enter a search term."
    end
    if params[:query] != ""
      hashtags = API.hashtags(params[:query])
      @hashtags = hashtags(hashtags)
    end
  end

  #def highlight(text, search_string)
  #  keywords = search_string.squeeze.strip.split(" ").compact.uniq
  #  matcher = Regexp.new( '(' + keywords.join("|") + ')' )
  #  highlighted = text.gsub(matcher) { |match| "#{match}" }

  #  return highlighted
  #end

  def hashtags(data)
    hash = {}
    data.each do |d|
      d.hashtags.each do |d|
        if d.text != nil
          hash[:"#{d.text.to_s}"]
        end
      end
    end
  end
end
