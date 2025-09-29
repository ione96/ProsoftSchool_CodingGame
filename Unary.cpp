#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <stdio.h>
#include <stdlib.h>


using namespace std;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

int main()
{
    string message;
    getline(cin, message);
    

    // Write an answer using cout. DON'T FORGET THE "<< endl"
    // To debug: cerr << "Debug messages..." << endl;

    int sizemes = message.size();  // size of message
    cerr << "size= " << sizemes << endl;
    string binmes = ""; // message character in binary
    for (int i = sizemes-1; i >= 0; i--) // for each symbol starting from the last one
    {
        int decmes = message[i]; // symbol in decimal
        cerr << "decimal= " << decmes << endl;
        for (int i = 0; i < 7; i++) // 7bit string
        {
        cerr << "decimal for= " << decmes << endl;
            if (decmes % 2 == 1) // convert decimal in binary
            {
                binmes = "1" + binmes; 
                decmes = decmes / 2;
                cerr << "binmes1= " << binmes << endl;
            }
            else // convert decimal in binary
            {
                binmes = "0" + binmes;
                decmes = decmes / 2;
                cerr << "binmes0= " << binmes << endl;
            }
        }
    }
    cerr << "binmes full= " << binmes << endl;
    cerr << "binmes[1]= " << binmes[1] << endl;
    string codemes = ""; // string to incode only 0
    for (int i = 0; i < binmes.size(); i++) //for each symbol
    {
        cerr << "binmes[i]= " << binmes[i] << endl;
        if (binmes[i] == '1') // check which character
        {
            codemes = codemes + "0 0"; // encode with one 0 and first symbol 0
            while (binmes[i+1] == '1')
            {
                codemes = codemes + "0"; // add 0 for each next symbol "1" in a row
                cerr << "codemes 1 = " << codemes << endl;
                i++;
            }
            codemes = codemes + " "; // space to separate next series
        }
        else
        {
            codemes = codemes + "00 0"; // encode with two 0 and first symbol 0
            while (binmes[i+1] == '0')
            {
                codemes = codemes + "0"; // add 0 for each next symbol "0" in a row
                cerr << "codemes 0 = " << codemes << endl;
                i++;
            }
            codemes = codemes + " "; // space to separate next series
        }
    }
    codemes.erase(codemes.size()-1, 1); // delete the last space in encoded message
    cout << codemes << endl;
}
