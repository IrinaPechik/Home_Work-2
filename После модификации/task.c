#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

char* task(const char *str, int n) {
    // Выделяем память для n ячеек типа int для подпоследовательности answer.
    char* answer = calloc(n, sizeof(int));
    int count = 1;
    int last_ind = 0;
    for (int i = 1; i < strlen(str); i++) {
        if (count == n) {
            last_ind = i - 1;
            break;
        }
        if (str[i - 1] > str[i]) {
            count++;
        } else {
            count = 1;
            last_ind = 0;
        }
        if (i == strlen(str) - 1) {
            if (count == n) {
                last_ind = i;
                break;
            }
        }
    }
    for (int i = 0; i < n; i++) {
        answer[i] = str[last_ind - n + 1 + i];
    }
    return answer;
}

char* task_rnd(int length, int n) {
    char* rndStr = calloc(length, sizeof(int));
    srand(clock());
    for (int i = 0; i < length; ++i) {
        rndStr[i] = (char) (33 + rand() % 93);
    }
    rndStr[length] = '\0';
    printf("Random string: %s", rndStr);
    return task(rndStr, n);
}

char* task_cmd(int n) {
    char string[256];
    printf("Your string (max - 256 characters):");
    fflush(stdin);
    getchar();
    fgets(string, 256, stdin);
    return task(string, n);
}