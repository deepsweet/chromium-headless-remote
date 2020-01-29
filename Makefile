# Docker Hub's Auto Builder is used to create versioned builds.
# Build instructions are set to look at tag value and create an image tag
# with same exact tag.
# For that reason we CANNOT use parameterized Dockerfile, and, instead,
# are using multiple Git Tags to point to same exact Git commit.
# (if there is a better way to Auto Build multiple image tags off same commit, suggest how)

# To bump the build version:
# 1. Run `make show-versions`
# 2. Pick newer version and paste here and in Dockerfile (properly shortening it)
# 3. Commit changes to this and Dockerfile files
# 4. Run `make tags`

show-versions:
	docker run -it --rm \
		ubuntu:bionic \
		bash -c "apt-get update && apt-cache policy chromium-browser"

# Run `make show-versions` to see latest versions
# Pick one that's higher than one below and paste here.
# Because actual package versions are long: '77.0.3865.90-0ubuntu0.18.04.1'
# we use wildcard in Dockerfile and shorten it here.
# Match the value here to that assigned to CHROMIUM_VERSION variable inside Dockerfile.
# Commit both changes, run `make push-tags` and wait for Docker Hub to build new images.
TAGS:=79.0.3945.79 79.0.3945 79.0 79

tags:
	for TAG in $(TAGS); do \
		git tag --force $$TAG; \
		git push --delete --quiet origin $$TAG 2> /dev/null || true; \
		git push origin $$TAG; \
	done