# Set up forgery. Just makes the empty dirs

puts "Setting up forgery ... ".magenta

generate 'forgery'

git :add => '.'
git :commit => "-am 'Generated forgery override dirs.'"
