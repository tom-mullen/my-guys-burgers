module ApplicationHelper
  def page_title
    title = content_for(:title).presence || "Burgers & Fries"
    "My Guys - #{title}"
  end
end
