#
# Cookbook Name:: wkhtmltopdf
# Recipe:: default
#

if ['util'].include?(node[:instance_role])

  ["media-libs/fontconfig", "x11-libs/libXext", "freefonts", "corefonts"].each do |pkg|
    package pkg do
      action :install
    end
  end

#  execute "install wkhtmltopdf" do
#    command "pdfkit --install-wkhtmltopdf"
#    not_if { "which wkhtmltopdf" }
#  end

end
