#include "listing.h"

int yyparse(void);

int main() {
    openFiles();
    firstLine();
    yyparse();
    lastLine();
    closeFiles();
    return 0;
}
