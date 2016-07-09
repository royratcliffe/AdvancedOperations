# coding: utf-8
Pod::Spec.new do |spec|
  spec.name = 'AdvancedOperations'
  spec.version = '0.1.10'
  spec.summary = 'Advanced NSOperations Framework for Swift'
  spec.description = <<-DESCRIPTION.gsub(/\s+/, ' ').chomp
  Framework that decouples the Advanced NSOperations concepts as much as
  possible in order to allow applications to take what they need, and not take
  what they do not need. You might call this NSOperations-lite.
  DESCRIPTION
  spec.homepage = 'https://github.com/royratcliffe/Operations'
  spec.license = { type: 'MIT', file: 'MIT-LICENSE.txt' }
  spec.authors = {
    'Roy Ratcliffe' => 'roy@pioneeringsoftware.co.uk' }
  spec.source = {
    git: 'https://github.com/royratcliffe/AdvancedOperations.git',
    tag: spec.version.to_s }
  spec.source_files = 'Sources/**/*.{swift,h}'
  spec.platform = :ios, '9.0'
  spec.requires_arc = true
end
