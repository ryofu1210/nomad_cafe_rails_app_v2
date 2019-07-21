class RedisService
  COUNT = 6

  # 日別のアクセスランキング
  def self.get_daily_post_ranking(date)
    $redis.zrevrange(daily_post_ranking_key(date), 0, COUNT)
  end

  # 日別エリア別のアクセスランキング
  def self.get_daily_area_post_ranking(date, area_id)
    $redis.zrevrange(daily_area_post_ranking_key(date, area_id), 0, COUNT)
  end

  # def self.get_post_pageviews(post_id)
  #   $redis.get()
  # end


  # アクセスされた時にカウントアップ
  def self.countup(post_id)
    post = Post.find(post_id)
    today = Date.today
    area_id = post.area.id
    $redis.pipelined do
      countup_daily_post_ranking(post.id, today)
      countup_daily_area_post_ranking(post.id, today, area_id)
      # countup_post_pageviews(post_id)
    end
  end

  private
  # 日別PVカウント
  def self.countup_daily_post_ranking(post_id, date)
    $redis.zincrby(daily_post_ranking_key(date),
                    1,
                    post_id)
  end

  # 日別エリア別PVカウント
  def self.countup_daily_area_post_ranking(post_id, date, area_id)
    $redis.zincrby(daily_area_post_ranking_key(date, area_id),
                    1,
                    post_id)
  end

  # Total PVカウント
  # def self.countup_post_post_pageviews(post_id)
  #   $redis.incr(post_pageviews_key(),
  #                 1,
  #                 post_id)
  # end


  # 日別PVカウント用キー
  def self.daily_post_ranking_key(date)
    "/ranking/date:#{date}"
  end

  # 日別エリア別PVカウント用キー
  def self.daily_area_post_ranking_key(date, area_id)
    "/ranking/area:#{area_id}/date:#{date}"
  end

  # Total PVカウント用キー
  # def self.post_pageviews_key()
  #   "/pageviews"
  # end

end
