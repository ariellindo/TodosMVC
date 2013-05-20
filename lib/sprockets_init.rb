# this is the assets manager setup, to make the require calls for the
# different assets like javascripts and CSS.
# this sinatra extension sets the root for those assets folders

module SprocketsInitializer
  module Assets

    def self.registered(app)

      app.set :assets_prefix, "assets"
      app.set :sprockets, Sprockets::Environment.new(app.root).tap { |assets|
        assets.append_path "assets/images"
        assets.append_path "assets/stylesheets"
        assets.append_path "assets/javascripts"
        assets.append_path "assets/javascripts/templates"
        assets.append_path "assets/vendor"
      }

      app.helpers do
        include Sprockets::Helpers

        Sprockets::Helpers.configure do |config|
          config.environment = sprockets
          config.prefix      = assets_prefix
          config.expand      = development?
          config.digest      = production?

        end

      end

      app.get "/#{app.assets_prefix}/*" do
        env["PATH_INFO"].sub!(%r{^/#{settings.assets_prefix}}, "")
        settings.sprockets.call(env)
      end

    end
  end

end
