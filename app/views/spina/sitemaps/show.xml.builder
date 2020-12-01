xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
  "xsi:schemaLocation" => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd", "xmlns:xhtml" => "http://www.w3.org/1999/xhtml" do
    
    @pages.each do |page|
      xml.url do
        xml.loc #{request.protocol}#{request.host}#{page.materialized_path == "/blog" && Spina::config[:blog_path] != "blog" ? "/" + Spina::config[:blog_path] : page.materialized_path}"

        # Translations
        page.translations.each do |translation|
          if translation.locale.in? Spina.config.locales.map(&:to_s)
            Mobility.with_locale(translation.locale) do
              xml.xhtml(:link, rel: "alternate", hreflang: translation.locale, href: "#{request.protocol}#{request.host}#{page.materialized_path}")
            end
          end
        end

        xml.lastmod page.updated_at.to_date
        xml.changefreq "weekly"
        xml.priority 0.9
      end
    end

    @posts.each do |post|
      xml.url do
        xml.loc "#{request.protocol}#{request.host}/#{Spina::config[:blog_path]}/#{post.slug}"
        xml.lastmod post.updated_at.to_date
        xml.changefreq "weekly"
        xml.priority 0.9
      end
    end

end