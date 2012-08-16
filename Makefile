CC        := g++
AR        := g++

SRC_DIR   := src
OBJ_DIR := obj
BUILD_DIR   := build

SRC       := $(foreach sdir,$(SRC_DIR),$(wildcard $(sdir)/*.cpp))
OBJ       := $(patsubst src/%.cpp,$(OBJ_DIR)/%.o,$(SRC))
INCLUDES  := $(addprefix -I,$(SRC_DIR))

vpath %.cpp $(SRC_DIR)

define make-goal
$1/%.o: %.cpp
	$(CC) -g $(INCLUDES) -c $$< -o $$@
endef

.PHONY: all checkdirs clean

all: checkdirs $(BUILD_DIR)/libstrmat.a

$(BUILD_DIR)/libstrmat.a: $(OBJ)
	$(AR) -shared -fPIC $^ -o $@

checkdirs: $(OBJ_DIR) $(BUILD_DIR)

$(OBJ_DIR):
	@mkdir -p $@

$(BUILD_DIR):
	@mkdir -p $@

clean:
	@rm -rf $(OBJ_DIR) $(BUILD_DIR)

$(foreach bdir,$(OBJ_DIR),$(eval $(call make-goal,$(bdir))))

