module MetaTagsHelper

  def default_meta_tags
    {
      separator: '|',
      site: '東京ノマドカフェ',
      # reverse: true,
      charset: 'utf-8',
      description: '東京にあるPC作業におすすめなWifiあり、コンセントあり、長居可のカフェをまとめたWebサービス',
      keywords: 'ノマド,東京,カフェ,Wifi',
      canonical: request.original_url,
      # icon: [
      #   { href: image_url('favicon.ico') },
      #   { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      # ],
      og: {
        site_name: :site,
        description: :description,
        type: 'website',
        url: request.original_url,
        # image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
    }
  end

  def posts_meta_tags(page=1,area=nil)

    tags = {
      title: "#{area.try(:name)}カフェ一覧 #{page}ページ目",
      canonical: request.original_url
    }
    set_meta_tags tags
  end

  def post_meta_tags(post)
    tags = {
      title: post.name,
      canonical: request.original_url
    }
    set_meta_tags tags
  end

end
