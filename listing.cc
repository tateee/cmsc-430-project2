#include <iostream>
#include <fstream>
#include <queue>
#include <string>
#include "listing.h"

using namespace std;

extern FILE* yyin;

static ifstream sourceFile;
static ofstream listingFile;
static int lineNumber;
static string line;
static queue<string> errorQueue;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;

void openFiles()
{
    yyin = fopen("input.txt", "r");
    sourceFile.open("input.txt");
    listingFile.open("listing.txt");
    lineNumber = 0;
}

void closeFiles()
{
    if (yyin) fclose(yyin);
    sourceFile.close();
    listingFile.close();
}

void firstLine()
{
    if (getline(sourceFile, line))
    {
        lineNumber++;
        listingFile << lineNumber << "  " << line << endl;
    }
}

void nextLine()
{
    displayErrors();
    if (getline(sourceFile, line))
    {
        lineNumber++;
        listingFile << lineNumber << "  " << line << endl;
    }
}

int lastLine()
{
    displayErrors();
    listingFile << endl;
    if (lexicalErrors + syntaxErrors + semanticErrors > 0)
    {
        listingFile << "Lexical Errors " << lexicalErrors << endl;
        listingFile << "Syntax Errors " << syntaxErrors << endl;
        listingFile << "Semantic Errors " << semanticErrors << endl;
    }
    else
    {
        listingFile << "Compiled Successfully" << endl;
    }
    return lexicalErrors + syntaxErrors + semanticErrors;
}

void appendError(ErrorCategories errorCategory, std::string message)
{
    switch (errorCategory)
    {
        case LEXICAL:
            lexicalErrors++;
            errorQueue.push("Lexical Error, " + message);
            break;
        case SYNTAX:
            syntaxErrors++;
            errorQueue.push("Syntax Error, " + message);
            break;
        case SEMANTIC:
            semanticErrors++;
            errorQueue.push("Semantic Error, " + message);
            break;
        default:
            break;
    }
}

void displayErrors()
{
    while (!errorQueue.empty())
    {
        listingFile << errorQueue.front() << std::endl;
        errorQueue.pop();
    }
}


