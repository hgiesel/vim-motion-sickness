require 'rspec/core/rake_task'

task :default => [:test]

task :test do
  sh <<~'EOF'
    vim -Nu <<< '
    filetype off\
    set rtp+=vader.vim
    set rtp+=.
    filetype plugin indent on
    syntax enable' -c 'Vader! test/*' > /dev/null
  EOF
end
