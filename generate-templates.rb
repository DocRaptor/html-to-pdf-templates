require 'rubygems'
require 'fileutils'

directories = Dir.glob('source/*').select { |fn| File.directory?(fn) }
directories.each do |directory|
  template = directory.split("/")[-1]
  output_dir = "templates/#{template}"
  FileUtils.mkdir_p(output_dir) unless File.directory?(output_dir)

  a4_template = <<~HEREDOC.chomp
    <style>
    #{File.read("#{directory}/style.A4.css")}
    </style>
    #{File.read("#{directory}/#{template}.html")}
  HEREDOC
  File.write("#{output_dir}/#{template}.A4.html", a4_template)
  puts "Generated #{template} A4 template..."

  us_letter_template = <<~HEREDOC.chomp
    <style>
    #{File.read("#{directory}/style.USLetter.css")}
    </style>
    #{File.read("#{directory}/#{template}.html")}
  HEREDOC
  File.write("#{output_dir}/#{template}.USLetter.html", us_letter_template)
  puts "Generated #{template} USLetter template..."
end
