SRC_ICON_FILE=$(SOURCE_DIR)/icon.png
INDEX_ENTRY_CLASS=printindex-index-entry

MANUAL_URL  = https://www.gnu.org/software/libtool/manual/libtool.html_node.tar.gz
MANUAL_FILE = tmp/libtool.html_node.tar.gz

$(MANUAL_FILE): tmp
	curl -o $@ $(MANUAL_URL)

$(DOCUMENTS_DIR): $(RESOURCES_DIR) $(MANUAL_FILE)
	mkdir -p $@
	tar -x -z -f $(MANUAL_FILE) -C $@

$(INDEX_FILE): $(SOURCE_DIR)/src/index-pages.py $(SCRIPTS_DIR)/gnu/index-terms.py $(DOCUMENTS_DIR)
	rm -f $@
	$(SOURCE_DIR)/src/index-pages.py $@ $(DOCUMENTS_DIR)/*.html
	$(SCRIPTS_DIR)/gnu/index-terms.py "Entry" $(INDEX_ENTRY_CLASS) $@ $(DOCUMENTS_DIR)/Combined-Index.html
