module PostsHelper
  def order_link(path, column, order)
    icon = (order == 'desc') ? '▼' : '▲'
    link_to eval("#{path}(#{{ 'post' => { column => order } } })") do
      content_tag(:span, icon)
    end
  end

  def title_in_body(area)
    return area.present? ? "#{area.name}のカフェ一覧" : "カフェ一覧"
  end
end
