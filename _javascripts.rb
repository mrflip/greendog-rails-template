

get "https://github.com/dotjay/hashgrid/raw/v5/hashgrid.js", "public/javascripts/hashgrid.js"

inject_into_file 'app/views/layouts/_javascripts.html.haml', :after => %Q{= yield :javascripts\n} do
  %Q{= javascript_include_tag 'hashgrid'}
end

