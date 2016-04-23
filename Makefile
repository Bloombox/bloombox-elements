
#
# - CostTree - bloombox-elements
#

BUILDBOT ?= 0
ENV ?= .env/
TARGET ?= target/
CREDENTIALS ?= 1

all: build
	@echo "bloombox-elements is ready."


#
## Build Flow
#

build: $(TARGET) $(ENV) dependencies
	@echo "Project build complete."

release: build
	@echo "Building release package..."
	@mkdir -p $(TARGET)/
	@cp -frv ./bloombox-elements.html ./index.html ./bower.json ./README.md $(TARGET)/;
	@tar -czvf release.tar.gz $(TARGET)/
	@mv release.tar.gz $(TARGET)/
	@echo "Release ready."

dependencies:
	@echo "Installing project dependencies..."
	@bower install
	@echo "Dependencies ready."

clean:
	@echo "Cleaning project..."
	@find . -name .DS_Store -delete
	@rm -frv $(TARGET)

distclean: clean
	@echo "Resetting project..."
	@rm -frv $(TARGET) $(ENV)
	@git reset --hard

forceclean: distclean
	@echo "Sanitizing project..."
	@git clean -xdf

#
## Dependencies
#

$(ENV):
	@echo "Establishing envroot..."
	@mkdir -p $(ENV)

$(TARGET):
	@echo "Establishing buildroot..."
	@mkdir -p $(TARGET)


.PHONY: all build release dependencies clean distclean forceclean
