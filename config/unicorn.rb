#unicorn.rb

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  @sidekiq_pid ||= spawn("bundle exec sidekiq -C config/sidekiq.yml")

  puts "Sidekiq = #{@sidekiq_pid}"

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end
end