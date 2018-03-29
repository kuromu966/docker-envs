DATE		= LANG=en_US.UTF-8 date
CXX		= g++
CPPFLAGS	= -O2 -Wall -Wextra 
LDFLAGS		= -lboost_program_options -lpthread -lboost_system -lboost_log
STD		= -std=gnu++17

all: bin/sample
	make -C ./study CXX=$(CXX) CPPFLAGS=$(CPPFLAGS) STD=$(STD)

bin/sample: main.o study/calc.o
	@if [ -d ./bin ]; then \
	rm -rf ./bin; \
	fi
	-@mkdir -p ./bin;
	$(CXX) $(LDFLAGS) main.o -o ./bin/sample -L/usr/lib study/calc.o

main.o: main.cpp study/calc.hpp
	$(CXX) $(CPPFLAGS) -o main.o -c main.cpp -Istudy -I/usr/include $(STD)

.PHONY:clean
clean:
	-@rm -rf ./bin
	-@find . -name '*.o' -print | xargs rm
	-@find . -name '*~' -print | xargs rm
