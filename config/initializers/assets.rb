# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w( footer.css )

Rails.application.config.assets.precompile += %w( makepatterns_index.css )
Rails.application.config.assets.precompile += %w( makepatterns_new.css )
Rails.application.config.assets.precompile += %w( makepatterns_aboutme.css )

Rails.application.config.assets.precompile += %w( patterns_index.css )
Rails.application.config.assets.precompile += %w( patterns_show.css )

Rails.application.config.assets.precompile += %w( sessions_new.css )
Rails.application.config.assets.precompile += %w( sessions_account_setting.css )
Rails.application.config.assets.precompile += %w( users_new.css )

Rails.application.config.assets.precompile += %w( registrations_new.css )

Rails.application.config.assets.precompile += %w( controllers/hello_controller.js )
Rails.application.config.assets.precompile += %w( controllers/index.js )
Rails.application.config.assets.precompile += %w( dropdown.js )
Rails.application.config.assets.precompile += %w( tab.js )
Rails.application.config.assets.precompile += %w( knitting_editor.js )
