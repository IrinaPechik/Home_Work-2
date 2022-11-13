# Индивидуальное домашние задание №2 по "АВС" на тему "Обработка строк символов"
Печик Ирина Юрьевна, БПИ-217, Вариант-3
# Как пользоваться программой:
### Cпособы ввода данных:
* __Ввод с консоли:__

     Ввести после указания исполняемого файла __входную строку и число N__ 
     ```
     (./program.exe string N)
     ```
* __Ввод из файла:__

     Ввести после указания исполняемого файла название __входного файла, затем выходного, затем число N__ 
     ```
     (./program.exe input.txt output.txt N)
     ```
* __Рандомный ввод или консольный без указания первоначальной строки__
  
     Ввести после указания исполняемого файла __число N__ 
     ```
     (./program.exe N)
     ```
    Далее следовать инструкциям, которые разъясняет пользователю программа
# Решение на 4 балла:
### 1. Приведено решение на С:
---
* Главный файл: [main.c](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%94%D0%BE%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.c)

* Файл с функцией для нахождения первой строго убывающей подстроки из N символов [task.c](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%94%D0%BE%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.c)  
---
### 2. В полученную ассемблерную программу, откомпилированную без оптимизирующих и отладочных опций, добавлены комментарии, поясняющие эквивалентное представление переменных в программе на C:

---
* Главный файл (не модифицированный): [main.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%94%D0%BE%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.s)
* Файл с функцией для нахождения первой строго убывающей подстроки из N символов (не модифицированный): [task.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%94%D0%BE%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.s)
---
### 3. Из ассемблерной программы убраны лишние макросы за счет использования соответствующих аргументов командной строки:

* Из главного файла были убраны следующие строки:

```
1. Убрана строчка 40: endbr64
2. Убраны строчки 408 - 426: 
    .size	main, .-main
      .ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
      .section	.note.GNU-stack,"",@progbits
      .section	.note.gnu.property,"a"
      .align 8
      .long	1f - 0f
      .long	4f - 1f
      .long	5
    0:
      .string	"GNU"
    1:
      .align 8
      .long	0xc0000002
      .long	3f - 2f
    2:
      .long	0x3
    3:
      .align 8
    4:
```
  Получился модифицированный главный файл: [main.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.s)

* Из файла с функцией для для нахождения первой строго убывающей подстроки из N символов были убраны следующие строки:
```
 1. Убрана строчка 7: endbr64
 2. Убраны строчки: 243-261 
    .size	task_cmd, .-task_cmd
    .ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
    .section	.note.GNU-stack,"",@progbits
    .section	.note.gnu.property,"a"
    .align 8
    .long	1f - 0f
    .long	4f - 1f
    .long	5
  0:
    .string	"GNU"
  1:
    .align 8
    .long	0xc0000002
    .long	3f - 2f
  2:
    .long	0x3
  3:
    .align 8
  4:
  ```
 
  Получился модифицированный файл с функцией: [task.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.s)
### 4.  Модифицированная ассемблерная программа отдельно откомпилирована и скомпонована без использования опций отладки:

Были использованы следующие команды:

```
gcc -masm=intel \
    -fno-asynchronous-unwind-tables \
    -fno-jump-tables \
    -fno-stack-protector \
    -fno-exceptions \
    ./main.c \
    -S -o ./main.s
    
gcc -masm=intel \
    -fno-asynchronous-unwind-tables \
    -fno-jump-tables \
    -fno-stack-protector \
    -fno-exceptions \
    ./task.c \
    -S -o ./task.s
```

```
gcc ./main.s task.s -o program.exe
```
### 5. Представлено полное тестовое покрытие, дающее одинаковый результат на обоих программах:
Программы отработали верно на следующих тестах и выдали одинаково верные результаты:
 
* Тест №1

  ```
  4
  1234321
  ```
  ![TEST1 console](https://user-images.githubusercontent.com/100044301/201538901-e8357309-a6df-4145-b33e-9ad30b495282.jpg)

  
* Тест №2
  
    ```
    4
    98767743210
    ```
    ![TEST2 console](https://user-images.githubusercontent.com/100044301/201538909-4a2a1c49-a647-47d5-a0e5-cf8705e7ddb6.jpg)

    
* Тест №3
  
    ```
    5
    98767743210
    ```
    ![TEST3 console](https://user-images.githubusercontent.com/100044301/201538914-f81b2e95-ea1b-4177-80d5-4bed8b51a6af.jpg)


* Тест №4
   
    ```
    4
    432187654
    ```
    ![TEST4 console](https://user-images.githubusercontent.com/100044301/201538920-853c7a02-09d2-4c6b-8149-0e034a9c9d09.jpg)

   
 * Тест №5
   
    ```
    4
    ABCDCBA
    ```
    ![TEST5 console](https://user-images.githubusercontent.com/100044301/201538925-f6518443-6cef-4618-ba99-4d893ef46b9d.jpg)

# Решение на 5 баллов:

### 1.  В реализованной программе использовать функции с передачей данных через параметры:
---

  В файле с функцией task: [task.c](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.c)
        
  Я передавала данные через параметры следующим образом:
  
  ```
  char* task(const char *str, int n)
  char* task_rnd(int length, int n)
  char* task_cmd(int n)
  ```
---
### 2.  Использовать локальные переменные:
---

* Локальные переменные в главной функции [main.c](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.c):

```
    int i;
    char* my_str;
    time_t t_start;
    time_t t_end;
    char* result;
    char array_str[256];
    FILE *input;
    FILE* output;
    char* result;
    int choice;
    int len;
```

* Локальные переменные в функции [task.c](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.c)

```
char* answer;
int count;
int last_ind;
int i;
char* rndStr;
char string[256];

```

---

### 3.  В ассемблерную программу при вызове функции добавить комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата.
---

  * Главный файл: [main.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.s)
  * Файл task: [task.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.s)

---

### 4.  В функциях для формальных параметров добавить комментарии, описывающие связь между параметрами языка Си и регистрами (стеком).
---

  * Главный файл: [main.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.s)
  * Файл task: [task.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.s)

---

# Решение на 6 баллов
### 1. Рефакторинг программы на ассемблере за счет максимального использования регистров процессора. Добавление этой программы к уже представленным:

---

Были заменены все локальные переменные на регистры:

* В главной функции [main.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.s)

	* Добавлен r13d вместо i (25 строка в main.c)	

* В функции для создания массива В [task.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.s)

	 * Добавлен r15d вместо переменной-итератора i в цикле for в task(const char *str, int n)
  
   * Добавлен r15d вместо переменной-итератора i в цикле for в task_rnd(int length, int n)
  

---

### 2. Добавление комментариев в разработанную программу, поясняющих эквивалентное использование регистров вместо переменных исходной программы на C:

---

* Главный файл: [main.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.s)
* Файл task: [task.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.s)

---

### 3. Представление результатов тестовых прогонов для разработанной программы. Оценка корректности ее выполнения на основе сравнения тестовых прогонов результатами тестирования предшествующих программ:

Программы отработали верно на следующих тестах и выдали одинаково верные результаты:
 
* Тест №1

  ```
  4
  1234321
  ```
  ![TEST1 console](https://user-images.githubusercontent.com/100044301/201538901-e8357309-a6df-4145-b33e-9ad30b495282.jpg)

  
* Тест №2
  
    ```
    4
    98767743210
    ```
    ![TEST2 console](https://user-images.githubusercontent.com/100044301/201538909-4a2a1c49-a647-47d5-a0e5-cf8705e7ddb6.jpg)

    
* Тест №3
  
    ```
    5
    98767743210
    ```
    ![TEST3 console](https://user-images.githubusercontent.com/100044301/201538914-f81b2e95-ea1b-4177-80d5-4bed8b51a6af.jpg)


* Тест №4
   
    ```
    4
    432187654
    ```
    ![TEST4 console](https://user-images.githubusercontent.com/100044301/201538920-853c7a02-09d2-4c6b-8149-0e034a9c9d09.jpg)

   
 * Тест №5
   
    ```
    4
    ABCDCBA
    ```
    ![TEST5 console](https://user-images.githubusercontent.com/100044301/201538925-f6518443-6cef-4618-ba99-4d893ef46b9d.jpg)

### 4. Сопоставление размеров программы на ассемблере, полученной после
компиляции с языка C с модифицированной программой, использующей
регистры.
  * В программе после модификации ~ 600 строк кода. При этом ее вес составляет 14 KiB.
  * В программе до модификации ~ 640 строк кода. При этом ее вес составляет 15 KiB.
  
# Решение на 7 баллов:

### 1.  Реализация программы на ассемблере, полученной после рефакторинга, в виде двух или более единиц компиляции.
---
Две единицы компиляции:
    
* Главная функция: [main.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.s)

* Функция task: [task.s](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.s)
---

### 2. Задание файлов с исходными данными и файла для вывода результатов с использованием аргументов командной строки.
---
* Главная функция: [main.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.c)

Добавили в main: 
```
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
```

* Функция task: [task.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.c)
 
 #### Прогон на тестах:
 
Тип входных данных: строка ASCII + число int (N);
Тип выходных данных: строка ASCII - первая строго убывающая подстрока из N символов

Входные данные из консоли -> выходные из консоли
Входные данные из файла -> выходные в файле
Более подробные правила ввыода смотреть в начале.

![Test 1 File](https://user-images.githubusercontent.com/100044301/201540893-58220da2-cc0e-43a9-9a26-157d911ca52d.jpg)
![Test 2 File](https://user-images.githubusercontent.com/100044301/201540897-99a0c53e-f83a-4602-aee9-ff415017adf1.jpg)
![Test 3 File](https://user-images.githubusercontent.com/100044301/201540899-7204c59f-4e6e-4a80-953d-c52dc5699164.jpg)
![Test 4 File](https://user-images.githubusercontent.com/100044301/201540904-2cfa1a10-8c62-466e-a6a5-ea012d2f59a9.jpg)
![Test 5 File](https://user-images.githubusercontent.com/100044301/201540910-abe5d247-0c13-45f4-aede-1f683fb1ed38.jpg)

Набор данных тестов: [tests](https://github.com/IrinaPechik/Home_Work-2/tree/main/%D1%82%D0%B5%D1%81%D1%82%D1%8B)

---

# Решение на 8 баллов:

### 1. Добавление в программу генератора случайных наборов данных, расширяющих возможности тестирования:
---
* Главная функция: [main.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.c)
Добавили в task: 
```
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
```

* Функция task: [task.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.c)

Корректно пройдено тестирование:
![Test random 1](https://user-images.githubusercontent.com/100044301/201541329-2f7cb45c-794c-4ddb-a453-4848879aa2e2.png)
![Test random 2](https://user-images.githubusercontent.com/100044301/201541333-cffd2406-c694-49c9-8f49-06aa9da054bf.png)
![Test random 3](https://user-images.githubusercontent.com/100044301/201541338-57c802b2-c262-47ae-89c0-8b1567dccb3f.png)

---

### 2. Генератор подключен к программе с выбором в командной строке варианта ввода данных:

* Главная функция: [main.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.c)
* Функция task: [task.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.c)

Если количество элементов введённых в консоль равно:
  * 3 => консольный ввод
  * 4 => файловый ввод
  * 2 => рандом / консоль (без первоначального ввода строки)
  
    ```
    if (argc == 3) {}
    if (argc == 4) {}
    if (argc == 2) {}
    ```
  
 ### 3. Добавены замеры во времени, которые не учитывают время ввода и вывода данных.
* Главная функция: [main.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/main.c)
* Функция task: [task.с](https://github.com/IrinaPechik/Home_Work-2/blob/main/%D0%9F%D0%BE%D1%81%D0%BB%D0%B5%20%D0%BC%D0%BE%D0%B4%D0%B8%D1%84%D0%B8%D0%BA%D0%B0%D1%86%D0%B8%D0%B8/task.c)

Добавили в main:
```
time_t t_start = clock();
        printf("Str: %s\n", my_str);
        for (int i = 0; i < 25000000; ++i) {
            task(my_str, N);
        }
        time_t t_end = clock();
        printf("Time: %d ms", (int) (difftime(t_end, t_start)) / 1000);
```
По результатом замеров, было выявлено, что модифицированная программа работает быстрее:
  * Не модифицированная (1)
  ![Test timer 1 non-optim](https://user-images.githubusercontent.com/100044301/201541804-c16ee593-2ae3-44ef-a31c-ac8ac83b13fc.png)

  * Модифицированная (1)
  ![Test timer 1 optim](https://user-images.githubusercontent.com/100044301/201541807-41e4e168-8b73-4f95-82c8-8014f7160f17.png)

  * Не модифицированная (2)
  ![Test timer 2 non-optim](https://user-images.githubusercontent.com/100044301/201541812-066dfc71-83d6-4af6-969c-9c22543b879e.png)

  * Модифицированная (2)
  ![Test timer 2 optim](https://user-images.githubusercontent.com/100044301/201541818-52e64bf7-5345-4238-9820-10af01544779.png)

  # Решение на 9 баллов:
  
  Сравнение веса и скорости программы до и после модификации:
  | Программа          | Количество строк| Скорость | Вес  |
  |--------------------|-----------------|----------|------|
  |C                   |    166          |   1692   | 5.2  |
  |Ассемблер (без мод.)|    687          |   1802   | 17.17|
  |Ассемблер (мод.)    |    647          |   1020   | 16.31|
  
