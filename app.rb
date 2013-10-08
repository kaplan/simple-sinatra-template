require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/assetpack'
require 'coffee-script'
require 'sass'

class App < Sinatra::Base
  # Set Sinatra's variables
  set :app_file, __FILE__
  set :root, File.dirname(__FILE__) # You must set app root
  set :views, "views"
  # set :public_dir, 'static' # if you had a folder not named 'public'

  register Sinatra::AssetPack

  configure :development do
     register Sinatra::Reloader
     set :scss, {:style => :expanded}
     # set :scss, {:style => :nested}
     # set :scss, {:style => :compressed}
     # set :scss, {:style => :compact}
   end

  assets {
    serve '/js',      from: 'assets/js'        # Default
    serve '/css',     from: 'assets/css'       # Default
    serve '/images',  from: 'assets/images'    # Default

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)

    js :app, 'js/app.js', [
      'js/vendor/**/*.js',
      'js/lib/**/*.js'
    ]

    css :application, '/css/application.css', [
      '/css/normalize.css',
      '/css/app.css',
      '/css/main.css'
    ]

    js_compression  :js_compression         # :jsmin | :yui | :closure | :uglify
    # you can tweak the output_settings if you use configure
    # css_compression :simple               # :simple | :sass | :yui | :sqwish
    # css_compression :sass
  }

  get '/' do
    erb :index
  end

end