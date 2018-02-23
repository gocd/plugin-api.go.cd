module ViewTemplateHelpers
  def version_select_dropdown
    page_info = current_page_info

    if data.plugins[page_info[:extension_type]].all_versions.length == 1
      concat_content("<span class='one-version'>#{data.plugins[page_info[:extension_type]].all_versions[0]} (latest)</span>")
      return
    end

    concat_content("<select class='version'>")
    data.plugins[page_info[:extension_type]].all_versions.each do |version|
      is_latest_version = version == data.plugins[page_info[:extension_type]].current
      version_url = "/#{page_info[:extension_type]}/#{version}"
      html = content_tag :option, value: version,
                         data: {url: version_url},
                         selected: version == page_info[:version] do
        if is_latest_version
          "#{version} (latest)"
        else
          version
        end
      end

      concat_content(html)
    end
    concat_content("</select>")
  end

  def current_page_info
    if current_page.path.match(/\A(\S*)\/(\S*)\/(\S*)\z/)
      extension_type, version, page_name = current_page.path.match(/\A(\S*)\/(\S*)\/(\S*)\z/).captures
      return {extension_type: extension_type, version: version, page_name: page_name}
    end

    if current_page.path.match(/\A(\S*)\/(\S*)\z/)
      extension_type, page_name = current_page.path.match(/\A(\S*)\/(\S*)\z/).captures
      return {extension_type: extension_type, latest_version: data.plugins[extension_type].current, page_name: page_name}
    end
  end
end

