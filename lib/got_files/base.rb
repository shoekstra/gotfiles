require 'got_files/string'

module GotFiles
  class Base
    include FileUtils

    def command_exist?(command)
      system("which #{command} > /dev/null 2>&1")
    end

    def git(url, path, msg = nil)
      if File.directory?(path)
        unless `git -C "#{path}" remote -v`.split(/\n/).grep(/origin/).first.match(url)
          puts "[Directory already exists] Moving #{path} to #{path}_backup..."
          system %(mv "#{path}" "#{path}_backup")
        end

        puts "Updating #{msg}..." if msg
        system %(git -C "#{path}" pull -q origin master)
        system %(git -C "#{path}" submodule -q update)

        return
      end

      puts "Installing #{msg}..." if msg
      system %(git clone -q #{url} #{path})
      system %(git -C "#{path}" submodule -q init)
      system %(git -C "#{path}" submodule -q update)
    end

    def install_file(file, dot = true)
      files = [file].flatten.map { |f| File.expand_path(f) }
      files.each do |f|
        source = install_file_source(f)
        target = install_file_target(f, dot)

        backup_file(source, target)
        create_symlink(source, target)
      end
    end

    def brew_install_if_missing(package, package_name = nil)
      return if package_installed?(package)

      puts "\nInstalling #{package_name}..." if package_name
      run %(brew install #{package})
    end

    def brew_cask_install_if_missing(package, package_name = nil)
      return if cask_package_installed?(package)

      puts "\nInstalling #{package_name}..." if package_name
      run %(brew install #{package})
    end

    def plistbuddy(command, plist)
      system %(/usr/libexec/PlistBuddy -c '#{command}' ~/Library/Preferences/#{plist} )
    end

    private

    def backup_file(source, target)
      return unless File.exist?(target)
      return if File.symlink?(target) && File.readlink(target) == source

      puts "Overwriting #{target}, leaving original at #{target}_backup..."
      system("mv '#{target}' '#{target}_backup'")
    end

    def create_symlink(source, target)
      return if File.symlink?(target) && File.readlink(target) == source

      puts "Linking #{target} -> #{source}"
      system("ln -nfs '#{source}' '#{target}'")
    end

    def has_dot?(file)
      File.basename(file)[0] == '.'
    end

    def install_file_source(file)
      if file.include? ENV['HOME']
        file
      else
        "#{ENV['PWD']}/#{file}"
      end
    end

    def install_file_target(file, dot = true)
      target = "#{ENV['HOME']}/"
      target << '.' unless has_dot?(file) || dot == false
      target << File.basename(file)
    end

    def cask_package_installed?(package)
      system("brew cask list | grep ^#{package}$", :out => File::NULL)
    end

    def package_installed?(package)
      system("brew list | grep ^#{package}$", :out => File::NULL)
    end

    def run(cmd)
      `#{cmd}` unless ENV['DEBUG']
    end
  end
end
