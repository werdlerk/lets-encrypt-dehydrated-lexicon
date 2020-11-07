registry = 'werdlerk'
name = File.basename(__dir__)
version = 'latest'

task default: %w(build push)

task :build do
  no_cache = '--no-cache' if ENV['cache'] == 'false'
  sh "docker build #{no_cache} -t #{registry}/#{name}:#{version} ."
end

task :push do
  sh "docker push #{registry}/#{name}:#{version}"
end

task :run do
  sh "docker run -it --rm --name #{name} -e 'STAGE=true' -e 'CHALLENGE_TYPE=dns-01' -e 'CONTACT_EMAIL=myemail@gmail.com' -e 'PROVIDER=cloudflare' -e 'LEXICON_CLOUDFLARE_USERNAME=myemail@gmail.com' -e 'LEXICON_CLOUDFLARE_TOKEN=XXXXXXXXX' -v '#{File.expand_path('data')}/:/data' #{registry}/#{name}:#{version}"
end