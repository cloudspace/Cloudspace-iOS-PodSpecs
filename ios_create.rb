require 'find'
require 'fileutils'
require 'rubygems'
require 'cocoapods'
require 'debugger'

renameable_content_extensions = [
  ".h", ".m", ".c", ".cpp", ".xib",
  ".nib", ".storyboard", ".pch", ".plist",
  ".xcodeproj", ".xcworkspace", ".pbxproj",
  ".xcscheme", ".xcworkspacedata", ".strings",
  ".xcdatamodel", ".xcdatamodeld",
]

base_project_name = 'CSPROJECTNAME'
base_project_prefix = 'CSPREFIX'

#
# Don't continue if the right dependencies aren't installed
#
if !`which git 2>/dev/null` and $?.success?
  puts 'Git is not installed.  Please install git  before continuing'
  exit
end

if !ARGV[0]
  puts 'You must specify a project name'
  exit
end

if ARGV[0] !~ /^[A-Za-z0-9]+$/
  puts "Your project name must be alpha number and have no spaces"
  exit
end

if ARGV[1] !~ /^[A-Za-z]+$/
  puts "Your project prefix must uppercase letters only with no spaces"
  exit
end

#
# Get new project name
#
project_name = ARGV[0]

#
# Get new project prefix
#
project_prefix = ARGV[1]

#
# Create directory if it doesn't exist
#
if File.directory? './' + project_name
  puts "This directory already exists"
  exit
end

#
# Clone repo
#
puts 'Cloning base iOS project repository'
command = 'git clone git@github.com:cloudspace/Cloudspace-iOS.git \'./' + project_name + '\''
result = `#{command}`

#
# Replace existing git repo with new one
#
puts 'Replacing git repository with new init'
FileUtils.rm_rf('./' + project_name + '/.git')
result = `git init`


require 'pathname'

def find_depth_first(pathname)
  acc = []
  pathname.find { |file| acc << file }
  acc.reverse!
  acc.each { |path| yield path }
end

find_depth_first(Pathname('./' + project_name)) { |path|
  if path.directory?
    # Rename directories
    patharray = path.to_s.split("/")

    patharray.last[base_project_prefix] = project_prefix if patharray.last.include? base_project_prefix
    patharray.last[base_project_name]   = project_name if patharray.last.include? base_project_name
    
    new_path = patharray.join("/")

    path.rename(new_path) if new_path != path
  elsif renameable_content_extensions.include? File.extname(path)
    # Rename names references in files
    text = File.read(path)
    text = text.gsub(/#{base_project_prefix}/, project_prefix)
    text = text.gsub(/#{base_project_name}/, project_name)
    File.open(path, "w") {|file| file.puts text}

    # Rename the files if appropriate
    patharray = path.to_s.split("/")

    patharray.last[base_project_prefix] = project_prefix if patharray.last.include? base_project_prefix
    patharray.last[base_project_name]   = project_name   if patharray.last.include? base_project_name
    new_path = patharray.join("/")

    path.rename(new_path) if new_path != path
  end

  

}

#
# Update pods
#
puts 'Updating pods'
puts `cd ./#{project_name};pod install`

puts
puts '------------------------------------------------'
puts 'Your project is now ready for use.'
puts 'Open ' + project_name + '.xcworkspace to begin'
puts '------------------------------------------------'