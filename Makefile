FLUTTER := $(shell which flutter)
FLUTTER_BIN_DIR := $(shell dirname $(FLUTTER))
DART := $(FLUTTER_BIN_DIR)/cache/dart-sdk/bin/dart

test_coverage:
	$(FLUTTER) test --coverage 
	genhtml coverage/lcov.info -o coverage/html
	open coverage/html/index.html       




