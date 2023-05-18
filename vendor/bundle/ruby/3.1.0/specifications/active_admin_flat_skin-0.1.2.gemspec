# -*- encoding: utf-8 -*-
# stub: active_admin_flat_skin 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "active_admin_flat_skin".freeze
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Armand Niampa".freeze]
  s.bindir = "exe".freeze
  s.date = "2015-07-12"
  s.description = "Flat design skin for active admin.".freeze
  s.email = ["armand.niampa@gmail.com".freeze]
  s.homepage = "http://ayann.github.io/active_admin_flat_skin".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Flat design skin for active admin.".freeze

  s.installed_by_version = "3.3.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.8"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.8"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
