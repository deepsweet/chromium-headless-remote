# Docker Hub's Auto Builder is used to create versioned builds.
# Build instructions are set to look at tag value and create an image tag
# with same exact tag.
# For that reason we CANNOT use parameterized Dockerfile, and, instead,
# are using multiple Git Tags to point to same exact Git commit.
# (if there is a better way to Auto Build multiple image tags off same commit, suggest how)

# To bump the build version:
# 1. Run `make list`
# 2. Pick newer version and paste here and in Dockerfile (properly shortening it)
# 3. Commit changes to this and Dockerfile files
# 4. Run `make push`

list:
	docker run -it --rm \
		ubuntu:bionic \
		bash -c "apt-get update && apt-cache policy chromium-browser"

TAGS:=80.0.3987.87 80.0.3987 80.0 80

push:
	for TAG in $(TAGS); do \
		git tag --force $$TAG; \
		git push --delete --quiet origin $$TAG 2> /dev/null || true; \
	done
	git push --follow-tags

.PHONY: list push