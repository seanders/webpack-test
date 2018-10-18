require 'open3'

logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(STDOUT))

def write_bundle_hash_to_manifest(raw_output)
  public_path = Rails.root.join('public')
  match = raw_output.split("\n")[6].match(/.+([0-9]|[a-z])?\.js/)
  new_bundle_name = match.to_s

  File.open(public_path.join('manifest.json'), "w") { |io|
    io << new_bundle_name
  }
end

namespace :assets do
  task :precompile do
    stdout, sterr , status = Open3.capture3("yarn build")

    if status.success?
      logger.info stdout
      # write new hash manifest to file so rails can read it
      write_bundle_hash_to_manifest(stdout)
    else
      logger.error "Compilation failed:\n#{sterr}\n#{stdout}"
    end
  end
end

