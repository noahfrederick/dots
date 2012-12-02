require 'rake'

task :default => [:install]

desc "Install dotfiles by creating symlinks and initializing submodules"
task :install => [:submodule_update, :link]

desc "Link dotfiles into user's home directory"
task :link do
  replace_all = false

  Dir['*'].each do |file|
    next if %w[Rakefile README.md].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file}")
        puts "Already linked ~/.#{file}"
      elsif replace_all
        replace_file file
      else
        print "Overwrite ~/.#{file} [ynaq]? "
        case $stdin.gets.chomp
        when 'y'
          replace_file file
        when 'a'
          replace_all = true
          replace_file file
        when 'q'
          exit
        else
          puts "Skipping ~/.#{file}"
        end
      end
    else
      link_file file
    end
  end
end

desc "Run 'git submodule update --init' on dotfile repository"
task :submodule_update do
  system 'git submodule update --init'
end

def replace_file file
  system %Q{rm -rf "$HOME/.#{file}"}
  link_file file
end

def link_file file
  puts "Linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
