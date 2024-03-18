BIN_DIR := bin
FILES := $(shell ls)
OUTFILES := $(FILES:%.hs=$(BIN_DIR)/%)

all: $(OUTFILES)
	

$(BIN_DIR)/%: %.hs
	mkdir -p $(BIN_DIR)
	ghc -o $@ $<
	mv *.hi $(BIN_DIR)
	mv *.o $(BIN_DIR)

test:
	echo $(OBJECTS)


clean:
	rm -rf $(BIN_DIR)