class QueriesController < ApplicationController
  def index

  end

  def show
    if params[:query] == ""
      redirect_to root_path
      flash[:notice] = "You must enter a search term."
    end
    
    if params[:query] != ""
      query = API.makecall(params[:query])
      
      @test = query
      
      @hashtags = hashtags(query)
      @mentions = mentions(query)
    end
  end
  
  private

  def highlight(text, search_string)
    keywords = search_string.squeeze.strip.split(" ").compact.uniq
    matcher = Regexp.new( '(' + keywords.join("|") + ')' )
    highlighted = text.gsub(matcher) { |match| "#{match}" }

    return highlighted
  end

  def hashtags(data)
    @hash = {}
    data.each do |d|
      d.hashtags.each do |d|
        if d.text != nil
          name = d.text.to_s
          if !@hash.has_key? name
            @hash[name] = 0
          end
          @hash[name] = @hash[name] + 1
        end
      end
    end
    return @hash
  end
  
  def mentions(data)
    @mentions = {}
    data.each do |d|
      d.user_mentions.each do |d|
        if d.screen_name != nil
          name = d.screen_name.to_s
          if !@mentions.has_key? name
            @mentions[name] = 0
          end
          @mentions[name] = @mentions[name] + 1
        end
      end
    end
    return @mentions
  end
end