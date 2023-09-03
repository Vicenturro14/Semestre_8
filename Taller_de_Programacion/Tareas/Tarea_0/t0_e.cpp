#include <iostream>

void beautiful_towers(void);

int main() {
    int tests_num;
    std::cin >> tests_num;
    for (int i = 0; i < tests_num; i++) {
        beautiful_towers();
    } 
    return 0;
}

void beautiful_towers(void) {
    char lastChar = ' ';
    int repeatCounter = 0;
    int n, m;
    std::cin >> n;
    std::cin >> m;

    std::string s1, s2;
    std::cin >> s1;
    std::cin >> s2;
    for (int j = 0; j < n; j++) {
        if (lastChar == s1[j]) repeatCounter++;
        lastChar = s1[j];
    }
    for (int k = m-1; k >=0; k--) {
        if (lastChar == s2[k]) repeatCounter++;
        lastChar = s2[k];
    }
    if (repeatCounter > 1) std::cout << "NO" << "\n";
    else std::cout << "YES" << "\n";
}
