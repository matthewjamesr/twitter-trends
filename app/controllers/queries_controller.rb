class QueriesController < ApplicationController

  require 'date'

  time = Time.now.to_s
  @time = DateTime.parse(time).strftime("%m/%d/%Y %H:%M")

  def index
    $tracker.track(@time, "Index Hit")
  end

  def show
    if params[:query] == ""
      redirect_to root_path
      flash[:notice] = "You must enter a search term."
    else
      log_search
      query = API.makecall(params[:query], 1000)
      @test = query
      hashtags(query)
      mentions(query)
      geocords(query)

      $tracker.track(@time, "Results Hit")
      $tracker.track(params[:query], "Search Term", {
        "Time" => @time,
        "Query" => params[:query]
      })
    end
  end

  private

  def log_search
    if current_user
      search = Search.new
      search.user_id = current_user.id
      search.query = params[:query]
      search.save
    end
  end

  def highlight(text, search_string)
    keywords = search_string.squeeze.strip.split(" ").compact.uniq
    matcher = Regexp.new( '(' + keywords.join("|") + ')' )
    highlighted = text.gsub(matcher) { |match| "#{match}" }

    return highlighted
  end

  def geocords(data)
    @geo = {}
    @coords = ""
    @place = {}

    data.each do |d|
      if d.geo?
        if !@geo.has_key? d.place.bounding_box.coordinates
          @geo[d.place.bounding_box.coordinates] = 0
          geo = d.place.bounding_box.coordinates
          @coords = @coords + "{\n"
          4.times do |x|
            @coords = @coords + ":latlng => [" + geo[0][x][0].to_s + ", " + geo[0][x][1].to_s + "],\n"
          end
          @coords = @coords + "},\n"
        end
        @geo[d.place.bounding_box.coordinates] = @geo[d.place.bounding_box.coordinates] + 1
      end
      if d.place?
        if !@place.has_key? d.place.full_name
          @place[d.place.full_name] = 0
        end
        @place[d.place.full_name] = @place[d.place.full_name] + 1
      end
    end
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
