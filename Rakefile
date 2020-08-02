$LOAD_PATH.unshift File.expand_path './lib'

Rake::TaskManager.record_task_metadata = true
Rake.add_rakelib 'lib/tasks'

desc 'install EVERYTHING'
task :install do
  require 'highline/import'

  Rake.application.in_namespace(:install) do |namespace|
    namespace.tasks.sort_by { |t| t.name }.each do |t|
      Rake::Task[t.name].invoke if HighLine.agree("#{t.comment.capitalize}? ")
    end
  end
end
