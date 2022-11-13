#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

#define max_size 256

extern char* task(const char* str, int N);
extern char* task_rnd(int length, int N);
extern char* task_cmd(int N);

int main(int argc, char* argv[]) {
    int N;
    // Timer and console.
    if (argc == 3) {
        char* my_str = argv[1];
        // Длина подпоследовательности.
        N = atoi(argv[2]);
        if (N < 2 || N > max_size) {
            printf("Incorrect size of N\n");
            return 0;
        }
        time_t t_start = clock();
        printf("Str: %s\n", my_str);
        for (int i = 0; i < 25000000; ++i) {
            task(my_str, N);
        }
        time_t t_end = clock();
        printf("Time: %d ms", (int) (difftime(t_end, t_start)) / 1000);
        char* result = task(my_str, N);
        if (strlen(result) == 0) {
            printf("\nThere is no suitable substring\n");
            return 0;
        }
        printf("\nResult: %s\n", result);
        return 0;
    }

    // Ввод данных из файла и вывод в файл. Названия обоих файлов передаётся
    // в качестве параметров + последний аргумент - N => argc = 4.
    if (argc == 4) {
        N = atoi(argv[3]);
        if (N < 2 || N > max_size) {
            printf("Incorrect size of N\n");
            return 0;
        }
        char array_str[256];
        // Открываем уже существующий файл для чтения.
        FILE *input = fopen(argv[1], "r");
        // Если файла не существует выводим соответствующее сообщение об ошибке.
        if (input == NULL) {
            printf("Error opening the file.To continue, press any key.\n");
            getchar();
            return 0;
        }
        // Помещаем в наш массив array_str данные из файла input.
        fgets(array_str, sizeof(array_str), input);
        // Закрываем поток.
        fclose(input);

        // Открываем файл для записи (если такой файл ранее существовал -> перезаписываем).
        FILE* output = fopen(argv[2], "w");
        // Записываем в файл.
        char* result = task(array_str, N);
        if (strlen(result) == 0) {
            fprintf(output, "%s", "There is no suitable substring\n");
            fclose(output);
            return 0;
        }
        fprintf(output, "%s", result);
        // Закрываем поток.
        fclose(output);
        return 0;
    }

    // Производим рандомный или консольный ввод данных без аргументов командной строки.
    if (argc == 2) {
        N = atoi(argv[1]);
        if (N < 2 || N > max_size) {
            printf("Incorrect size of N");
            return 0;
        }
        printf("For random input - enter 1, for a console one - any other key\n");
        int choice = 0;
        scanf("%d", &choice);
        // Random.
        if (choice == 1) {
            int len = 0;
            printf("Input length (0 < length <= %d): ", max_size);
            scanf("%d", &len);
            if (len < 1 || len > max_size) {
                printf("Incorrect length = %d\n", len);
                return 0;
            }
            char* result = task_rnd(len, N);
            if (strlen(result) == 0) {
                printf("\nThere is no suitable substring\n");
                return 0;
            }
            printf("\nResult: %s\n", result);
            return 0;
        }
        // Console.
        char* result = task_cmd(N);
        if (strlen(result) == 0) {
            printf("\nThere is no suitable substring\n");
            return 0;
        }
        printf("\nResult: %s\n", result);
        return 0;
    }
    return 0;
}
