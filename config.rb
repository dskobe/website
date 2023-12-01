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

  # Extracts the start date from a string.
  def parse_start_date(date_str)
    # Handle date ranges by extracting only the start date
    start_date_str = date_str.split(' - ').first
    begin
      # Parse the start date
      Date.strptime(start_date_str, '%Y/%m/%d') rescue nil
    rescue ArgumentError
      nil
    end
  end

  def format_month_year(date_str, locale = :en)
    I18n.locale = locale
    # Extract the start date from a range or a single date
    start_date_str = date_str.split(' - ').first
    begin
      # Format the start date to "Month Year" based on the locale
      Date.strptime(start_date_str, '%Y/%m/%d').strftime(I18n.t('date.formats.calendar_headline')) rescue date_str
    rescue ArgumentError
      date_str
    end
  end

  def extract_day_or_range(date_str)
    if date_str.include?('-')
      start_date, end_date = date_str.split(' - ').map { |d| d.split('/').last }
      "#{start_date} - #{end_date}"
    else
      date_str.split('/').last
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
  activate :asset_hash, ignore: [/\.jpg\Z/, /\.png\Z/, /\.svg\Z/]
end
