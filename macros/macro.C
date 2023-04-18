/**
* Example ROOT main macro with command line args, and loading functions from another ROOT macro.
*/

// C++ Includes
#include <iostream>

// ROOT Includes
#include "TCanvas.h"
#include "TROOT.h"
#include "TGraphErrors.h"
#include "TF1.h"
#include "TLegend.h"
#include "TArrow.h"
#include "TLatex.h"
#include "TSystem.h"

// Local Includes
#include "lib.C"

int main(int argc, char** argv) {
    libfunc();
    std::cout<<"argc = "<<argc<<std::endl;//DEBUGGING
    for (int i=0; i<argc; i++) {
        std::cout<<"argv["<<i<<"] = "<<argv[i]<<std::endl;//DEBUGGING
    }
    std::cout<<"DONE"<<std::endl;//DEBUGGING
    return 0;
} // void main()
