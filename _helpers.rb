# Set up some view helpers and partials

puts "Creating useful application_helper.rb ...".magenta

remove_file 'app/helpers/application_helper.rb'
file 'app/helpers/application_helper.rb', <<-RUBY.gsub(/^ {2}/, '')
  module ApplicationHelper

    # Help individual pages to set their HTML titles
    def title(text)
      content_for(:title){ text }
    end

    # Help individual pages to set their HTML meta descriptions
    def description(text)
      content_for(:description){ text }
    end

    #
    # Link to a resource by its titleized text
    #
    # link_to_rsrc @dataset  => <a href="/datasets/dataset-handle" dataset.title
    # link_to_rsrc Dataset   => /datasets
    #
    def link_to_rsrc rsrc, options={}
      return '' unless rsrc
      case rsrc
      when ActiveRecord::Base then dest = rsrc                        ; text = rsrc.titleize
      when Class              then dest = url_for(rsrc.to_s.tableize) ; text = rsrc.to_s.titleize.pluralize
      when Symbol             then dest = rsrc                        ; text = rsrc.to_s.titleize.pluralize
      else                         dest = rsrc
      end
      link_to(text, dest, options)
    end
  end
RUBY

file 'app/helpers/error_messages_helper.rb', <<-RUBY.gsub(/^ {2}/, '')
  module ErrorMessagesHelper
    # Render error messages for the given objects. The :message and :header_message options are allowed.
    def error_messages_for(*objects)
      options = objects.extract_options!
      options[:header_message] ||= "Invalid Fields"
      options[:message] ||= "Correct the following errors and try again."
      messages = objects.compact.map { |o| o.errors.full_messages }.flatten
      unless messages.empty?
        content_tag(:div, :class => "error_messages") do
          list_items = messages.map { |msg| content_tag(:li, msg) }
          content_tag(:h2, options[:header_message]) + content_tag(:p, options[:message]) + content_tag(:ul, list_items.join.html_safe)
        end
      end
    end

    module FormBuilderAdditions
      def error_messages(options = {})
        @template.error_messages_for(@object, options)
      end
    end
  end

  ActionView::Helpers::FormBuilder.send(:include, ErrorMessagesHelper::FormBuilderAdditions)
RUBY

# Use inside forms like this:
#
# = form_for @user do |f|
#   = render '/shared/error_messages', :target => @user
file 'app/views/shared/_error_messages.html.haml', <<-HAML.gsub(/^ {2}/, '')
  - if target.errors.any?
    #errorExplanation
      %h2
        = pluralize(target.errors.count, "error")
        prohibited this record from being saved:
      %ul
        - target.errors.full_messages.each do |msg|
          %li= msg
HAML

git :commit => "-am 'Generated Helpers.'"
