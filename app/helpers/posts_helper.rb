module PostsHelper
  @@color_min = '#26FF60' # green
  @@color_max = '#FF3F25' # red
  
  def votes_to_color(votes)  

    max_votes = Post.maximum(:votes)
    min_votes = Post.minimum(:votes)
    amount = (votes - min_votes)/(max_votes.to_f - min_votes)
    minColor = Color::RGB.from_html(@@color_min)
    maxColor = Color::RGB.from_html(@@color_max)

    tweened_color = tweenColors(minColor,maxColor,amount)

    return tweened_color::html
  end

  def tweenColors(from,to,amt)
    # tween between two colors to find the color in between
    # from<color> - hex color, 0%
    # to<color>   - hex color, 100% 

    # convert each color to HSV
    from_hsl = from.to_hsl
    to_hsl   = to.to_hsl 
    
    # tween
    out_h = (to_hsl.h - from_hsl.h) * amt + from_hsl.h
    out_s = (to_hsl.s - from_hsl.s) * amt + from_hsl.s
    out_l = (to_hsl.l - from_hsl.l) * amt + from_hsl.l

    out_color = Color::HSL.from_fraction(out_h,out_s,out_l)

    return out_color
  end
  def updateAllColors
    out = ""
    Post.all.each do |post|
     out +="$('#post-#{post.id}').css('background-color','#{votes_to_color(post.votes) }');"
    end
    out
  end
end
