class QueriesController < ApplicationController

  require 'date'

  def index
    time = Time.now.to_s
    time = DateTime.parse(time).strftime("%m/%d/%Y %H:%M")

    Mixpanel.track(time, "Index Hit")
  end

  def show
    if params[:query] == ""
      redirect_to root_path
      flash[:notice] = "You must enter a search term."
    end

    if params[:query] != ""
      time = Time.now.to_s
      time = DateTime.parse(time).strftime("%m/%d/%Y %H:%M")

      Mixpanel.track(time, "Results Hit")
      Mixpanel.track(params[:query], "Search Term", {
        'Time' => time
      })

      query = API.makecall(params[:query], 500)

      @test = query

      hashtags(query)
      mentions(query)
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
        name = d.text.to_s
        if !@hash.has_key? name
          @hash[name] = 0
        end
        @hash[name] = @hash[name] + 1
      end
    end
    return @hash
  end

  def mentions(data)
    @mentions = {}
    data.each do |d|
      d.user_mentions.each do |d|
        name = d.screen_name
        if !@mentions.has_key? name
          @mentions[name] = 0
        end
        @mentions[name] = @mentions[name] + 1
      end
    end
    return @mentions
  end
end
