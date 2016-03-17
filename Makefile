build: node_modules 
	@echo "Running build..."
	@node build

watch:
	@echo "Running build with watch..."
	@node build --watch=true

node_modules: package.json
	@echo "Installing packages..."
	@npm install

clean:
	@echo "Cleaning..."
	rm -rf build
	rm -rf tmp
	rm -rf src/content/snapcraft/

fetch_snapcraft_docs: clean
	@echo "Fetching latest snapcraft docs..."
	@mkdir -p tmp
	@git clone https://github.com/ubuntu-core/snapcraft/ tmp/snapcraft
	@cp -r tmp/snapcraft/docs src/content/snapcraft/
	@echo "Annotating snapcraft docs with YAML frontmatter..."
	@node scripts/frontmatterise.js --path=src/content/snapcraft

test:
	@npm run test

.PHONY: build watch fetch_snapcraft_docs clean test
