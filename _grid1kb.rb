# Set up custom 960px CSS grid

puts "Creating CSS grid framework ...".magenta

inject_into_file 'app/stylesheets/style.sass', :after => %Q{@import "partials/example";\n\n} do
  <<-SASS.gsub(/^ {4}/, '')
    // Import the custom grid layout
    @import partials/grid1kb

  SASS
end

copy_static_file 'app/stylesheets/partials/_grid1kb.sass'
