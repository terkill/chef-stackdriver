group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec rspec', :all_on_start => true do
    watch(/^spec\/(.+)_spec\.rb$/)
    watch(/^recipes\/(.+)\.rb$/) { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { 'spec' }
  end

  guard :foodcritic, :cli => '', :cookbook_paths => '.' do
    watch(/attributes\/.+\.rb$/)
    watch(/providers\/.+\.rb$/)
    watch(/recipes\/.+\.rb$/)
    watch(/resources\/.+\.rb$/)
    watch(/^templates\/(.+)/)
    watch('metadata.rb')
  end

  guard :rubocop, :all_on_start => true do
    watch(/.+\.rb$/)
    watch(/(?:.+\/)?\.rubocop\.yml$/) { |m| File.dirname(m[0]) }
  end
end
