CSOURCES := $(shell find . -name "*.c")
CPPSOURCES := $(shell find . -name "*.cpp")
CFLAGS := -Wall -Wextra -Wfloat-equal -MMD

debug: CXXFLAGS := $(CFLAGS) -g
all: CXXFLAGS := $(CFLAGS) -fstack-protector-all -O3
coverage: CXXFLAGS := $(CFLAGS) -g -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=bounds-strict -fstack-protector-all -fprofile-arcs -ftest-coverage
werror: CXXFLAGS := $(CFLAGS) -Werror -g -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=bounds-strict -fstack-protector-all

all: CFLAGS := $(CXXFLAGS) -Wstrict-prototypes
debug: CFLAGS := $(CXXFLAGS) -Wstrict-prototypes
coverage: CFLAGS := $(CXXFLAGS) -Wstrict-prototypes
werror: CFLAGS := $(CXXFLAGS) -Wstrict-prototypes

LDLIBS := -lm -lpthread -lstdc++
all: LDFLAGS := -fstack-protector-all
coverage: LDFLAGS := -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=bounds-strict -fstack-protector-all -fprofile-arcs -ftest-coverage
werror: LDFLAGS := -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=bounds-strict -fstack-protector-all

all: main
debug: main
werror: main
coverage: main

main: $(CSOURCES:%.c=%.o) $(CPPSOURCES:%.cpp=%.o)

DEPS := $(shell find -name "*.d")
-include $(DEPS)

clean:
	rm -f main
	rm -f *.o
	rm -f *.d
