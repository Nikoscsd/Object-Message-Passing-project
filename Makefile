# Generic Makefile for simple c++ projects 
# Author George Kostomanolakis Dec. 15 2021

# the name of your executable, change it to your liking
TARGET = object.exe

# launches your target in terminal
RUN = ./$(TARGET)

# directory for your source files
SRC_DIR = src

# directory for your object files
BUILD_DIR = bin

# add more CompilerFLAGS as your project requires
# change c++11 to c++14 or 17 etc.. to change c++ version
CFLAGS = -std=c++17 -Wall -Wextra

# add libraries for your project here
LDFLAGS = 

# add library linker commands here (start with -l)
LOADLIBS = 

# add library search paths here (start with -L)
LDLIBS = 

# add include paths (start with -I)
INC = 

# finds all your objects that corrispond to your .cpp files, system agnostic version
OBJECTS := $(patsubst $(SRC_DIR)/%.cc, $(BUILD_DIR)/%.o, $(wildcard $(SRC_DIR)/*.cc))

.PHONY: all
# makes build directory, updates your objects, builds your executable
all: 
	mkdir -p $(BUILD_DIR)
	+$(MAKE) $(TARGET)

# updates your objects, builds your executable
$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) $(CFLAGS) -o $@ $(LOADLIBS) $(LDFLAGS) $(LDLIBS) $(INC)

# builds your objects
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cc
	$(CXX) $(CFLAGS) -c $< -o $@ $(LOADLIBS) $(LDFLAGS) $(LDLIBS) $(INC)

# deletes your built objects and executable
.PHONY: clean
clean:
	-rm -rf $(BUILD_DIR) $(TARGET)

# makes build directory, updates your objects, builds your executable, launches your program
.PHONY: run
run: 
	+$(MAKE) all
	$(RUN)


# explains the only three options you should be using (unless you build more of your own)
.PHONY:
help:
	@echo "---- Only requirement: put all your source files in a src folder! ------------------"
	@echo "| make - builds/updates everything, is ready to run with make run after completion |"
	@echo "| make clean - removes object file folder and executable                           |"
	@echo "| make run - builds/updates everything, runs immediately                           |"
	@echo "------------------------------------------------------------------------------------"