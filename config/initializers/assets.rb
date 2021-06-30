# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
#アセットのバージョンを文字列で設定する記述

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.

Rails.application.config.assets.paths << Rails.root.join('node_modules')
#アセットの探索パスはデフォルトではnode_modulesのディレクトリが指定されていないため上記の記述により指定する

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

# Rails.application.config.assets.precompile += %w( admin.js admin.css )
#上記の記述はプレコンパイルするファイルを配列で指定します。デフォルトでassete以下のjs、cssはプレコンパイル対象になっている