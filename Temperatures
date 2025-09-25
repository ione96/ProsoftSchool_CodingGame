// Temperatures
// Your program must analyze records of temperatures to find the closest to zero.

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

int main()
{
    int n; // the number of temperatures to analyse
    cin >> n; cin.ignore();
    cerr << "n= " << n << endl; // debug output of n-variable
    int A[n]; // array of temperatures
    for (int i = 0; i < n; i++) {
        int t; // a temperature expressed as an integer ranging from -273 to 5526
        cin >> t; cin.ignore();
        cerr << "t= " << t << endl; // debug output of t-variables
        A[i] = t;
    }

    // Write an answer using cout. DON'T FORGET THE "<< endl"
    // To debug: cerr << "Debug messages..." << endl;
    int mintemp = A[0]; // variable of minimal temperature
    if (n == 0)
    {
        cout << n << endl; // output if no temperature
    }
    else
    {  
        for (int i = 0; i < (n-1); i++) // for all temperatures
        {
            if (A[i+1] >= 0 & mintemp >= 0) // if both temperatures are positive
            {
                if (A[i+1] < mintemp) // compare next temperature with the minimum
                {
                    mintemp = A[i+1]; // remember if next is lower
                }
            }
            else if (A[i+1] < 0 & mintemp >= 0) // if next temperature is negative and minimal temperature is positive
            {
                if (A[i+1]*(-1) < mintemp) // remember if the negative temperature is lover (and not equal) then minimal positive
                {
                    mintemp = A[i+1];
                }
            }
            else if (A[i+1] >= 0 & mintemp < 0) // if next temperature is positive and minimal temperature is negative
            {
                if (A[i+1] <= mintemp*(-1)) // remember if the positive temperature is lover and equal then minimal negative
                {
                    mintemp = A[i+1];
                }
            }
            else if (A[i+1] < 0 & mintemp < 0) // if both temperatures are negative
            {
                if (A[i+1]*(-1) < mintemp*(-1)) // remember if the next temperature is lover then minimal
                {
                    mintemp = A[i+1];
                }
            }
        }
    cout << mintemp << endl; //output 
    } 
}
