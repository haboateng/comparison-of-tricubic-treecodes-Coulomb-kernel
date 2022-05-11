#CXX = icpc
CXX = clang++
#CXX = g++
#CXXFLAGS = -O2 -Wno-unused-result
#CXXFLAGS = -c -g -O2 -Wno-c++11-extensions
CXXFLAGS = -c -O2 -Wno-c++11-extensions -fno-cxx-exceptions


DEPENDENCIES = tricubic_utils.o tree_utils.o kernel_utils.o utilities.o


all:	direct_sum Tricubic_DC Tricubic_C0 Tricubic_C1 

#-----------------------------------------------------

direct_sum: direct_sum.o kernel_utils.o utilities.o
	$(CXX) direct_sum.o kernel_utils.o utilities.o -o direct_sum

direct_sum.o: direct_sum.cpp
	$(CXX) $(CXXFLAGS) direct_sum.cpp


#-----------------------------------------------------

Tricubic_DC: Tricubic_DC.o $(DEPENDENCIES)
	$(CXX) Tricubic_DC.o $(DEPENDENCIES) -o Tricubic_DC  

Tricubic_DC.o: Tricubic_DC.cpp
	$(CXX) $(CXXFLAGS) Tricubic_DC.cpp

#-----------------------------------------------------
Tricubic_C1: Tricubic_C1.o $(DEPENDENCIES)
	$(CXX) Tricubic_C1.o $(DEPENDENCIES) -o Tricubic_C1

Tricubic_C1.o: Tricubic_C1.cpp
	$(CXX) $(CXXFLAGS) Tricubic_C1.cpp

#-----------------------------------------------------
Tricubic_C0: Tricubic_C0.o $(DEPENDENCIES)
	$(CXX) Tricubic_C0.o $(DEPENDENCIES) -o Tricubic_C0

Tricubic_C0.o: Tricubic_C0.cpp
	$(CXX) $(CXXFLAGS) Tricubic_C0.cpp

#-----------------------------------------------------

tricubic_utils.o: tricubic_utils.cpp tricubic_utils.h tree_utils.o
	$(CXX) $(CXXFLAGS) tricubic_utils.cpp

tree_utils.o: tree_utils.cpp tree_utils.h kernel_utils.o
	$(CXX) $(CXXFLAGS) tree_utils.cpp

kernel_utils.o: kernel_utils.cpp kernel_utils.h utilities.o
	$(CXX) $(CXXFLAGS) kernel_utils.cpp

utilities.o: utilities.cpp utilities.h
	$(CXX) $(CXXFLAGS) utilities.cpp


#-----------------------------------------------------

clean:
	rm *.o *~

