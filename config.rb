activate :directory_indexes

set :css_dir, 'assets/css'
set :js_dir, 'assets/js'
set :images_dir, 'assets/images'

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

helpers do
  # Returns a localized path with leading language code
  def local_path(path, options={})
    "/#{path}"
  end

  def local_resource(path, options={})
    sitemap.resources
      .select{ |resource| resource.path.include?("#{path}") }
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

configure :development do
  activate :livereload do |reload|
    reload.no_swf = true
  end
end

configure :production do
  activate :minify_html
  activate :asset_hash, ignore: [/\.jpg\Z/, /\.png\Z/, /\.svg\Z/]
end
