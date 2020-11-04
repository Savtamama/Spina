module Spina
  class SitemapsController < Spina::ApplicationController
    def show
      I18n.locale = I18n.default_locale
      @pages = Page.live.sorted
      @posts = !Spina::config[:blog_path].nil? ? Spina::Blog::Post.live : []
    end
  end
end
