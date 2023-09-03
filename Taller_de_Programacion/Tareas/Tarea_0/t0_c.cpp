#include <iostream>

int main() {
    std::string str;
    std::cin >> str;
    char nextChar = 'a';
    for (unsigned int i = 0; i < str.size(); i++) {
        if (str[i] > nextChar) {
            std::cout << "NO" << "\n";
            return 0;
        } else if (str[i] == nextChar) nextChar++;
    }
    std::cout << "YES" << "\n";
    return 0;
}