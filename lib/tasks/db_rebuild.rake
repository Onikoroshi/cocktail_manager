namespace :db do
  desc "Rebuild (drop, create, migrate) db. Then seed and clone."
  task :rebuild => :environment do
    start = Time.now
    raise "This task can not be run in this environment." unless %w[development beta].include? Rails.env

    # if something fails and you are unable to access the db, you can drop it with the following:
    # /usr/bin/dropdb 'store-dev'
    # /usr/bin/dropdb 'store-test'
    # modified from http://stackoverflow.com/a/5408501/444774

    puts "Forcibly disconnecting other processes from database...(You may need to restart them.)"

    require 'active_record/connection_adapters/postgresql_adapter'
    module ActiveRecord
      module ConnectionAdapters
        class PostgreSQLAdapter < AbstractAdapter
          def drop_database(name)
            raise "Nah, I won't drop the production database" if Rails.env.production?

            begin
              psql_version_num = execute "select setting from pg_settings where name = 'server_version_num'"
              if psql_version_num.values.first.first.to_i < 90200
                #puts "version < 9.2"
                psql_version_pid_name = 'procpid'
              else
                #puts "version >= 9.2"
                psql_version_pid_name = 'pid'
              end

              execute <<-SQL
                UPDATE pg_catalog.pg_database
                SET datallowconn=false WHERE datname='#{name}'
              SQL

              execute <<-SQL
                SELECT pg_terminate_backend(pg_stat_activity.#{psql_version_pid_name})
                FROM pg_stat_activity
                WHERE pg_stat_activity.datname = '#{name}';
              SQL

              execute "DROP DATABASE IF EXISTS #{quote_table_name(name)}"
            ensure
              execute <<-SQL
                UPDATE pg_catalog.pg_database
                SET datallowconn=true WHERE datname='#{name}'
              SQL
            end
          end
        end
      end
    end

    system("rm -Rf #{Rails.root.join("tmp/storage")}/*")
    system("rm -Rf #{Rails.root.join("storage")}/*")

    puts "Dropping the db..."
    Rake::Task['db:drop'].invoke
    puts "Creating the db..."
    Rake::Task['db:create'].invoke
    puts "Migrating the db..."
    Rake::Task['db:migrate'].invoke
    puts "Seeding the db..."
    system("rake db:seed")
    puts "Cloning the test db..."
    Rake::Task['db:schema:dump'].invoke
    Rake::Task['db:test:load'].invoke
    puts "Done."

    ap "Finished in #{(((Time.now - start) / 1.minute).round(3))} minutes."
  end

  task :load_beta => :environment do
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['db:refresh_permissions'].invoke
  end

  desc "Dumps the database to db/APP_NAME.dump"
  task :dump => :environment do
    cmds = []
    with_config do |app, host, db, user, port|
      dir = "#{Rails.root}/tmp/db/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      cmds << "pg_dump --host #{host} --port #{port} --username #{user} --verbose --clean --no-owner --no-acl --format=c #{db} > #{dir}#{app}.dump"

      ap cmds

      cmds.each do |cmd|
        ap cmd
        exec cmd
      end
    end
  end

  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    cmd = nil
    with_config do |app, host, db, user, port, password|
      dir = "#{Rails.root}/tmp/db/"
      cmd = "pg_restore --host #{host} --port #{port} --username #{user} --dbname #{db} -C #{dir}#{app}.dump"
      puts cmd
      exec cmd
    end
    # Rake::Task["db:drop"].invoke
    # Rake::Task["db:create"].invoke
  end

  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username],
      ActiveRecord::Base.connection_config[:port],
      ActiveRecord::Base.connection_config[:password]
  end

end
