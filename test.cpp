#include <iostream>
#include <cstring>

int main() {
    char buffer[10];
    std::cout << "Enter a string: ";
    std::cin >> buffer;
    std::cout << "You entered: " << buffer << std::endl;
    return 0;
}