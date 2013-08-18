require 'rake'

task :default => [:install]

desc "Install dotfiles by creating symlinks and initializing submodules"
task :install => [:submodule_update, :link]

desc "Link dotfiles into user's home directory"
task :link do
  replace_all = false

  special_locations = {
    "bin"  => File.join(ENV['HOME'], "bin"),
    "fish" => File.join(ENV['HOME'], ".config", "fish"),
    "osx"  => nil
  }

  Dir['*'].each do |file|
    next if %w[Rakefile README.md].include? file

    # Some files should be linked to special destinations
    dest = if special_locations.has_key?(file)
             special_locations[file]
           else
             File.join(ENV['HOME'], ".#{file}")
           end

    if dest.nil?
      puts "Not linking #{file}"
    elsif File.exist?(dest)
      if File.identical? file, dest
        puts "Already linked #{dest}"
      elsif replace_all
        replace_file file, dest
      else
        print "Overwrite #{dest} [ynaq]? "
        case $stdin.gets.chomp
        when 'y'
          replace_file file, dest
        when 'a'
          replace_all = true
          replace_file file, dest
        when 'q'
          exit
        else
          puts "Skipping #{dest}"
        end
      end
    else
      link_file file, dest
    end
  end
end

desc "Run 'git submodule update --init' on dotfile repository"
task :submodule_update do
  system 'git submodule update --init'
end

def replace_file file, dest
  system %Q{rm -rf "#{dest}"}
  link_file file, dest
end

def link_file file, dest
  puts "Linking #{dest}"
  system %Q{ln -s "$PWD/#{file}" "#{dest}"}
end
