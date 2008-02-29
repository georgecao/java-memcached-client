# Generated by Buildr 1.2.10, change to your liking
# Version number for this release
VERSION_NUMBER = "2.0-pre8"
# Version number for the next release
NEXT_VERSION = VERSION_NUMBER
# Group identifier for your projects
GROUP = "spy"
COPYRIGHT = "2007  Dustin Sallings"

MAVEN_1_RELEASE = true
RELEASE_REPO = 'http://bleu.west.spy.net/~dustin/repo'
PROJECT_NAME = "memcached"
RELEASED_VERSIONS=%W(#{VERSION_NUMBER} 1.4 1.3.1 1.2 1.1 1.0.44)

# Specify Maven 2.0 remote repositories here, like this:
repositories.remote << "http://www.ibiblio.org/maven2/"
repositories.remote << "http://bleu.west.spy.net/~dustin/m2repo/"

require 'buildr/cobertura'

plugins=[
  'spy:m1compat:rake:1.0',
  'spy:site:rake:1.2.3',
  'spy:git_tree_version:rake:1.0',
  'spy:build_info:rake:1.1'
] 

plugins.each do |spec|
  artifact(spec).tap do |plugin|
    plugin.invoke
    load plugin.name
  end
end

desc "Java memcached client"
define "memcached" do

  options.java_args = "-ea"
  TREE_VER=tree_version
  puts "Tree version is #{TREE_VER}"

  project.version = VERSION_NUMBER
  project.group = GROUP
  manifest["Implementation-Vendor"] = COPYRIGHT
  compile.with m1("spy:spy:jar:2.4")

  # Gen build
  gen_build_info "net.spy.memcached", "git"
  compile.from "target/generated-src"
  resources.from "target/generated-rsrc"

  package(:jar).with :manifest =>
    manifest.merge("Main-Class" => "net.spy.memcached.BuildInfo\n")
end
# vim: syntax=ruby et ts=2
