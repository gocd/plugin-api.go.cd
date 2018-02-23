%w(
  render_all_sub_topics
  describe_object_helper
  available_since_helper
  view_template_helpers
).each do |f|
  require File.join(File.expand_path("../helpers", __FILE__), f)
end
