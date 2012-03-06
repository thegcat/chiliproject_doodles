require 'redmine'
require 'dispatcher'

Redmine::Plugin.register :chiliproject_doodles do
  name 'ChiliProject Doodles plugin'
  author 'Felix Schäfer'
  description 'Adds a doodle module to projects'
  version '0.6.0'
  url 'https://github.com/thegcat/chiliproject_doodles'
  author_url 'http://thegcat.net/'
  
  project_module :doodles do
    permission :manage_doodles, {:doodles => [:lock, :edit, :update]}, :require => :member
    permission :delete_doodles, {:doodles => [:destroy]}, :require => :member
    permission :create_doodles, {:doodles => [:new, :create, :preview]}, :require => :member
    permission :answer_doodles, {:doodle_answers => [:create, :update]}, :require => :loggedin
    permission :view_doodles, {:doodles => [:index, :show]}
  end
  
  menu :project_menu, :doodles, {:controller => 'doodles', :action => 'index'}, :caption => :label_doodle_plural, :param => :project_id
  
  activity_provider :doodles, :default => false, :class_name => ['Doodle', 'DoodleAnswersEdits']
end

Dispatcher.to_prepare do
  require_dependency 'chiliproject_doodles/mailer_patch'
  require_dependency 'chiliproject_doodles/project_patch'
  require_dependency 'chiliproject_doodles/view_hooks'
end
