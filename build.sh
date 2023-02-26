#!/usr/bin/env bash
# This file is used for deploy on Render
# https://render.com/docs/deploy-phoenix
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile
npm install --prefix ./assets
MIX_ENV=prod mix assets.deploy

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite

# Run migrations
_build/prod/rel/undi_online/bin/undi_online eval "Release.migrate"
