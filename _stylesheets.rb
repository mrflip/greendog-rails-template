# Set up custom stylesheet defaults

puts "Creating default stylesheets ...".magenta

remove_file 'app/stylesheets/partials/_example.sass'
gsub_file 'app/stylesheets/style.sass', %r{//@include html5-boilerplate;}, '@include html5-boilerplate'
gsub_file 'app/stylesheets/style.sass', %r{@import partials/example}, '//@import partials/example'

append_file 'app/stylesheets/style.sass', "@import partials/grid\n"

%w[page buttons flashes forms tables].each do |sass_partial|
  remove_file "app/stylesheets/partials/_#{sass_partial}.sass"
  append_file 'app/stylesheets/style.sass', "@import partials/#{sass_partial}\n"
  file "app/stylesheets/partials/_#{sass_partial}.sass", File.read(File.dirname(__FILE__)+"/files/app/stylesheets/partials/_#{sass_partial}.sass")
end
