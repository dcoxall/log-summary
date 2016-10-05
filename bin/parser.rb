#!/usr/bin/env ruby

require 'bundler'
Bundler.require(:default)
require_relative '../lib/log_summary.rb'

LogSummary::CLI.new($stdout).execute(*ARGV)
