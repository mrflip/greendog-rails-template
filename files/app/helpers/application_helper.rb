module ApplicationHelper

  # Help individual pages to set their HTML titles
  def title(text)
    @title = text
  end

  def skip_sidebar()  @skip_sidebar = true ; end
  def show_sidebar?() not @skip_sidebar    ;  end

  def has_javascript(javascript)
    content_for(:javascript){ javascript_include_tag(javascript) }
  end

  def has_stylesheet(stylesheet)
    content_for(:stylesheets){ stylesheet_link_tag(stylesheet) }
  end


  # This template will handle its own rows
  def multirow
    @multirow = true
  end

  # Help individual pages to set their HTML meta descriptions
  def description(text)
    content_for(:description){ text }
  end

  def cache_for_current_user(*args, &block)
    args << (current_user ? current_user.id : :logged_out)
    cache(args.flatten, &block)
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
    when Array              then dest = rsrc                        ; text = rsrc.last.titleize
    else                         dest = rsrc
    end
    link_to(text, dest, options)
  end


  def avatar_url(user, options={})
    size          = options[:s] || 36
    default_img   = "#{root_url}images/avatar-32.png"
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    query_params = []
    query_params << "s=#{size}"
    query_params << "d=#{CGI.escape(default_img)}"
    "http://www.gravatar.com/avatar/#{gravatar_id}?#{query_params.join('&')}"
  end
end
