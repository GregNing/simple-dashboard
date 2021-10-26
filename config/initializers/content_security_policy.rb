# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src :self, :https, :data
  policy.object_src :none
  policy.form_action :self
  policy.manifest_src :self

  if Rails.env.development?
    policy.connect_src :self, :https, "http://#{ViteRuby.config.host_with_port}", "ws://#{ViteRuby.config.host_with_port}"
    policy.script_src :self, :https, :unsafe_eval, "http://#{ViteRuby.config.host_with_port}", :unsafe_inline, 'https://polyfill.io'
    policy.script_src_elem :self, :unsafe_inline, "https://connect.facebook.net"
    policy.style_src_elem  :self, :unsafe_inline
  else
    policy.connect_src :self
    policy.script_src :self, :blob
  end

  # @inertiajs/progress uses inline styles
  policy.style_src :self, :unsafe_inline

  policy.base_uri :self
end
