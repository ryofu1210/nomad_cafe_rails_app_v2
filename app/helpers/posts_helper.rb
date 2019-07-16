module PostsHelper
  def order_link(path, column, order)
    icon = (order == 'desc') ? 'down' : 'up'
    link_to eval("#{path}(#{{ 'post' => { column => order } } })") do
      content_tag(:span, icon)
    end
  end
end
