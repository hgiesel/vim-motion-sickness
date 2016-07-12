require 'vimrunner'
require 'vimrunner/rspec'

Vimrunner::RSpec::configure do |config|
  config.reuse_server = true
  config.start_vim do
    vim = Vimrunner.start
    plugin_path = File::expand_path('..', __FILE__)
    vim.add_plugin(plugin_path, 'plugin/motion-sickness.vim')
    vim
  end
end
