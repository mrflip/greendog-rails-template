get "https://github.com/dotjay/hashgrid/raw/v5/hashgrid.js", "public/javascripts/hashgrid.js"

inject_into_file 'app/views/layouts/_javascripts.html.haml', :before => %Q{\n\s*= yield :javascripts} do
  %Q{= javascript_include_tag('hashgrid') if Rails.env.development?}
end
