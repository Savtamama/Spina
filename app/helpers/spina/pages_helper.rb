module Spina
  module PagesHelper

    def content(part_name)
      current_page.content(part_name)
    end

    def has_content?(part_name)
      current_page.has_content?(part_name)
    end

    def seo_title_tag
      "<title>#{current_account.name} | #{current_page.seo_title}</title>"
    end
    
    def seo_description_tag
      "<meta name=\"description\" content=\"#{current_page.description}\" />"
    end

    def seo_tags
      [seo_title_tag,seo_description_tag].join(' ').html_safe
    end
    
    def current_page
      Current.page
    end


  end
end