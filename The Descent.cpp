//The Descent
//A simple problem to try out the CodinGame platform: your program must find the highest mountain out of a list of mountains.


#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

/**
 * The while loop represents the game.
 * Each iteration represents a turn of the game
 * where you are given inputs (the heights of the mountains)
 * and where you have to print an output (the index of the mountain to fire on)
 * The inputs you are given are automatically updated according to your last actions.
 **/

int main()
{
int A[8]; //array with mountain's height
    // game loop
    while (1) {
        for (int i = 0; i < 8; i++) {
            int mountain_h; // represents the height of one mountain.
            cin >> mountain_h; cin.ignore();
            A[i] = mountain_h;
        }
        // Write an action using cout. DON'T FORGET THE "<< endl"
        // To debug: cerr << "Debug messages..." << endl;
        int MaxMount = 0; // variable of mountain with maximum height
        for (int i = 0; i < 7; i++) 
        {
            if (A[i+1] > A[MaxMount]) //if next height is bigger then previous
            {
                MaxMount = i+1; //remember the number of mountain
            }
        }
        cout << MaxMount << endl; // The index of the mountain to fire on.
    }
}
