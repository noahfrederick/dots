require 'fileutils'

USERNAME  = 'my'
KEYBOARDS = ['planck']
QMK_DIR   = "#{ENV['CODE']}/qmk_firmware"
USER_DIR  = "#{QMK_DIR}/users/#{USERNAME}"

def keymap_dir(keyboard)
  "#{QMK_DIR}/keyboards/#{keyboard}/keymaps/#{USERNAME}"
end

task default: :install

desc 'Symlink keymap files into QMK source tree'
task :install do
  FileUtils.ln_s(File.expand_path('user', __dir__), USER_DIR, verbose: true)

  KEYBOARDS.each do |keyboard|
    FileUtils.ln_s(File.expand_path(keyboard, __dir__), keymap_dir(keyboard), verbose: true)
  end
end

desc 'Remove symlinks from QMK source tree'
task :uninstall do
  FileUtils.rm_r USER_DIR, verbose: true, force: true

  KEYBOARDS.each do |keyboard|
    FileUtils.rm_r keymap_dir(keyboard), verbose: true, force: true
  end
end

desc 'Remove build artifacts'
task :clean do
  Dir.chdir(QMK_DIR) { sh 'make clean' }
end

desc 'Update QMK firmware'
task :pull do
  Dir.chdir(QMK_DIR) { sh 'git pull --ff-only' }
end
