.PHONY: print_vars

PROG=test
SRCS=$(PROG).cpp
OBJS=$(SRCS:.cpp=.o)

test: test.o
	echo $(CC) $(CXXFLAGS) $(LDFLAGS)
	$(CC) $(CXXFLAGS) $(LDFLAGS) -o $@ test.o

.cpp.o:
	echo $(CC) $(CPPFLAGS) $(CXXFLAGS)
	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $<

check: $(PROG)
	env | sort
	./$(PROG)

clean:
	$(RM) $(OBJS) $(PROG)

print_vars:
	echo $(CC) $(CC) $(CXXFLAGS) $(LDFLAGS)
	
