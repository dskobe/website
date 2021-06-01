activate :directory_indexes

activate :i18n do |i18n|
  i18n.path = "/:locale/"
  i18n.langs = [:en, :ja, :de, :fr]
  i18n.lang_map = { :en => :en, :ja => :ja, :fr => :fr, :de => :de }
  i18n.templates_dir = "content"
  i18n.mount_at_root = "en"
end

set :css_dir, '/assets'
set :js_dir, '/assets'
set :images_dir, '/assets/images'

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

helpers do
  # Returns a localized path with leading language code
  def local_path(path, options={})
    lang = options[:language] ? options[:language] : I18n.locale.to_s

    # Fallback for not localized languages
    if ['de','fr'].include? lang
      lang = 'en'
    end

    "/#{lang}/#{path}"
  end

  def local_resource(path, options={})
    lang = options[:language] ? options[:language] : I18n.locale.to_s

    # Fallback for not localized languages
    if ['de','fr'].include? lang
      lang = 'en'
    end

    sitemap.resources
      .select{ |resource| resource.path.include?("#{lang}/#{path}") }
      .first
  end

  # Returns all pages under a certain directory.
  def sub_pages(dir)
    sitemap.resources.select do |resource|
      resource.path.start_with?(dir)
    end
  end
end

activate :external_pipeline,
  name: :webpack,
  command: build? ? 'npm run build' : 'npm run watch',
  source: ".tmp/dist",
  latency: 1

# Dev environment
configure :development do
  activate :livereload do |reload|
    reload.no_swf = true
  end
end

configure :production do
  activate :minify_html
  # activate :asset_hash, ignore: [/\.jpg\Z/, /\.png\Z/, /\.svg\Z/]
end
