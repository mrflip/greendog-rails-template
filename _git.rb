# Create a .gitignore file and a new local repository, commit everything

puts "Initializing new Git repo ...".magenta

remove_file '.gitignore'
file '.gitignore', <<-CODE.gsub(/^ {2}/, '')
  ## OS
  .DS_Store
  Icon?
  nohup.out
  .bak

  ## EDITORS
  \#*
  .\#*
  *~
  *.swp
  REVISION
  TAGS*
  tmtags
  *_flymake.*
  *_flymake
  *.tmproj
  .project
  .settings
  mkmf.log

  ## COMPILED
  a.out
  *.o
  *.pyc
  *.so

  ## OTHER SCM
  .bzr
  .hg
  .svn

  ## PROJECT::GENERAL
  coverage
  rdoc
  doc
  pkg
  .yardoc
  *private*
  .bundle
  .vendor
  db/*.sqlite3
  log/*.log*
  tmp/**/*
  config/database.yml

CODE

git :init
git :add => "."
git :commit => "-am 'Initial commit.'"
