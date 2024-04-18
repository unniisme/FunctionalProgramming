BIN_DIR := bin
INCLUDE_DIR := include

all: bin/main

run: bin/main
	./bin/main

$(BIN_DIR):
	mkdir -p $(BIN_DIR) 

$(INCLUDE_DIR):
	mkdir -p $(INCLUDE_DIR)
	
bin/main: main.hs Parser.hs Syntax.hs $(BIN_DIR) $(INCLUDE_DIR)
	ghc -o bin/main main.hs -hidir $(INCLUDE_DIR) -odir $(BIN_DIR)

bin/calculator: Calculator/Syntax.hs Calculator/Types.hs Calculator/Calc.hs $(BIN_DIR) $(INCLUDE_DIR)
	ghc -o bin/calculator Calculator/Calc.hs -hidir $(INCLUDE_DIR) -odir $(BIN_DIR)

calc: bin/calculator
	./bin/calculator

clean:
	rm -rf $(BIN_DIR) $(INCLUDE_DIR)

	