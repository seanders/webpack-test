module ApplicationHelper
  # Creates a script tag that references the named pack file, as compiled by webpack per the entries list
  # in config/webpack/shared.js. By default, this list is auto-generated to match everything in
  # app/javascript/packs/*.js. In production mode, the digested reference is automatically looked up.
  #
  # Example:
  #
  #   <%= javascript_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <script src="/packs/calendar-1016838bab065ae1e314.js" data-turbolinks-track="reload"></script>
  def webpack_src
    src = sources_from_pack_manifest
    return src
  end

  def webpack_tag
    javascript_include_tag(webpack_src)
  end

  def sources_from_pack_manifest
    'bundles/' + File.read(manifest_path)
  end

  def manifest_path
    Rails.root.join('public', 'manifest.json')
  end
end
