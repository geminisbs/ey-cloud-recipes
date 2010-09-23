
define :resque_config, :app_name => nil do
  app = params[:app_name]

  master = nil
  node["utility_instances"].each do |util|
    if util["name"].match(/master$/)
      master = util["hostname"]
      break
    end
  end
  raise "Utility master could not be identified" unless master

  template "/data/#{app}/shared/config/resque.yml" do
    owner node["ssh_username"]
    group node["ssh_username"]
    mode 0644
    source "resque.yml.erb"
    variables({
      :master_ip => master,
      :rails_env => node[:environment][:framework_env]
    })
  end
end