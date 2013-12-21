module Autotable
  DEFAULT_OPTIONS = { action_class: "btn btn-xs" }

  class Builder
    def initialize(collection, template, options)
      @collection, @template = collection, template
      @options = DEFAULT_OPTIONS.merge(options)
      @columns, @actions = [], []
    end
    
    def column(method, title = nil, &formatter)
      if method.is_a?(String)
        title = method
        method = nil
      end
      
      @columns << {
        :method     => method,
        :title      => title || method.to_s.humanize,
        :formatter  => formatter
      }

      nil
    end
    
    def action(title, options = {})
      options[:title] = title
      @actions << options
    end
    
    def to_html
      html  = "<table class='#{table_class}'>\n"
      html << header_html
      html << "<tbody>\n"
      
      if @collection.empty?
        html << "<tr class='warning'>\n"
        html << "<td colspan='#{@columns.size + 1}'>No items found</td>\n"
        html << "</tr>\n"
      else
        @collection.each { |c| html << row_html(c) }
      end
      
      html << "</tbody>\n"
      html << "</table>\n"
      html.html_safe
    end
    
  private
    def h(html)
      ::CGI.escapeHTML(html)
    end

    def table_class
      klass = 'table'
      klass << ' table-striped'   if @options[:striped]
      klass << ' table-bordered'  if @options[:bordered]
      klass << ' table-hover'     if @options[:hover]
      klass << ' table-condensed' if @options[:condensed]
      klass
    end
  
    def header_html
      html  = "<thead>\n"
      html << "<tr>\n"
      
      @columns.each do |c|
        html << "<th>#{h(c[:title])}</th>\n"
      end
      
      html << "<th>Actions</th>\n"
      html << "</tr>\n"
      html << "</thead>\n"
      html
    end
    
    def row_html(object)
      html  = "<tr>\n"
      
      @columns.each do |col|
        value = col[:method] ? object.send(col[:method]) : nil
        if col[:formatter]
          value = col[:formatter].call(value,object) || ''
        else
          value = h(value || '')
        end
        html << "<td>#{value}</td>\n"
      end
      
      actions = @actions.map { |a|
        text = a[:title]
        
        if a[:icon]
          text = "<span class='glyphicon glyphicon-#{a[:icon]}'></span> #{text}"
        end
        
        if a[:url].is_a?(String)
          url = a[:url]
        elsif a[:url].is_a?(Proc)
          url = a[:url].call(object)
        elsif a[:url].is_a?(Hash)
          url = @template.url_for(a[:url].merge(:id => object))
        elsif a[:url].is_a?(Symbol)
          url = @template.send(a[:url], object)
        else
          url = '#'
        end

        action_class = @options[:action_class] + ' '
        action_class << a[:class] || 'btn-default'

        link_options = a.slice(:confirm, :method, :remote)
        link_options[:class] = action_class
        
        @template.link_to(text.html_safe, url, link_options)
      }.join(' ')
      
      html << "<td>#{actions}</td>"
      
      html << "</tr>\n"
    end
  end
end