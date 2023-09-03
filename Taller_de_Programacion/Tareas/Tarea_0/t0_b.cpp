#include <iostream>
#include <vector>

void findWord();

int main() {
    int tests_num;
    std::cin >> tests_num;
    for (int i = 0; i < tests_num; i++){
        findWord();
    }
    return 0;
}

void findWord() {
    char c;
    std::string word;
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            std::cin >> c;
            if (c != '.') {
                word.push_back(c);
            }
        }
    }
    std::cout << word << "\n";
}