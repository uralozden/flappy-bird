require 'sinatra'
require 'json'
require 'uuid'
require 'slim'
require 'sinatra/base'
require 'sinatra/assetpack'


unless Sinatra::Base.production?
  require 'byebug'
end

set :root, File.dirname(__FILE__)

####
#  Asset precompilation with assetpack:
#
register Sinatra::AssetPack
assets do
  serve '/js', :from => 'assets/javascripts'

  js :game, [
    '/js/game/phaser.min.js',
    '/js/game/main.js'
  ]

  js :application, [
    #'/js/vendor/*.js',
    #'/js/app.js'
  ]

  #serve '/css', :from => 'assets/stylesheets'
  #css :application, [
    ##'/css/normalize.css',
    ##'/css/app.css'
  #]

  serve 'images', :from => File.join('assets', 'images')

  js_compression :jsmin
  css_compression :sass
end

get "/" do
  data_images = %w(birdie.png clouds.png fence.png finger.png).map { |img|
    " data-#{img}='#{image_path "images/game/#{img}"}' "
  }.join
  data_sounds = %w(flap.wav score.wav hurt.wav).map { |sound|
    # use this line to silence the game, for my sanity:
    #" data-#{sound}='sounds-justsilence/game/#{sound}' "
    " data-#{sound}='sounds/game/#{sound}' "
  }.join
  data = data_images + data_sounds
  slim :index, :locals => { :data => data }
end

