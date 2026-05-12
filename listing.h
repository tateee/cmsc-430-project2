#ifndef LISTING_H
#define LISTING_H

#include <string>
using std::string;

enum ErrorCategories {LEXICAL, SYNTAX, SEMANTIC, DUPLICATE_IDENTIFIER, UNDECLARED};

void openFiles();
void closeFiles();
void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);
void displayErrors();

#endif
