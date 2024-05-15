
#!/usr/bin/awk -f

# Коментарі у AWK схожі на цей коментар.

# Програми AWK складаються з набору шаблонів і дій.
pattern1 { action; } # зовсім як lex
pattern2 { action; }

# Скрипт виконує неявний цикл, у якому AWK автоматично читає та аналізує кожен
# запис із кожного наданого йому файла. Кожен такий запис розділяється на поля
# роздільником FS, який за замовчуванням має значення пробіл (кілька пробілів
# або символів табуляції вважаються одним роздільником).
# Можна встановити значення FS в командному рядку (-FC) або у шаблоні BEGIN.

# Одним із спеціальних шаблонів є шаблон BEGIN. Цей шаблон є дійсним
# ДО прочитання будь-якого з вхідних файлів.
# Ще один спеціальний шаблон END є дійсним після кінця останнього з вказаних
# вхідних файлів, або після стандартного введення, якщо вхідні файли не вказано.
# Також використовується роздільник між полями виводу (OFS), значення якого
# ви також можете призначити, і для якого за замовчуванням встановлено
# значення один пробіл.


BEGIN {

    # BEGIN запускатиметься на початку програми. Тут розміщують весь код
    # попереднього налаштування перед обробкою будь-яких текстових файлів.
    # Якщо ваш скрипт не читає текстові файли, розглядайте BEGIN як
    # головну точку входу.

    # Змінні є глобальними. Просто встановіть їх і використовуйте.
    # Оголошувати змінні не потрібно.
    count = 0;

    # Оператори є такими ж як у мові C та схожих на неї мовах програмування.
    a = count + 1;
    b = count - 1;
    c = count * 1;
    d = count / 1; # цілочислене ділення
    e = count % 1; # модуль
    f = count ^ 1; # піднесення до степеня

    a += 1;
    b -= 1;
    c *= 1;
    d /= 1;
    e %= 1;
    f ^= 1;

    # Постфіксний оператор збільшення та зменшення на одиницю
    a++;
    b--;

    # Префіксний оператор, який повертає збільшене на одиницю значення
    ++a;
    --b;

    # Зверніть також увагу, що в кінці рядка не обов'язково вказувати
    # розділовий знак крапка з комою.

    # Оператор галудження
    if (count == 0)
        print "Starting with count of 0";
    else
        print "Huh?";

    # Можна використовувати тернарний оператор
    print (count == 0) ? "Starting with count of 0" : "Huh?";

    # Для блоків, що складаються з кількох рядків, використовують дужки
    while (a < 10) {
        print "String concatenation is done" " with a series" " of"
            " space-separated strings";
        print a;

        a++;
    }

    for (i = 0; i < 10; i++)
        print "Good ol' for loop";

    # Порівняння є стандартними:
    # a < b  # менше ніж
    # a <= b # менше або дорівнює
    # a != b # не дорівнює
    # a == b # дорівнює
    # a > b  # більше ніж
    # a >= b # більше або дорівнює

    # Логічні оператори також стандартні:
    # a && b # AND - І
    # a || b # OR  - АБО

    # Крім того, є перевірка на збіг із регулярним виразом:
    if ("foo" ~ "^fo+$")
        print "Fooey!";
    if ("boo" !~ "^fo+$")
        print "Boo!";

    # Масиви:
    arr[0] = "foo";
    arr[1] = "bar";

    # Також можна ініціалізувати масив за допомогою вбудованої функції split():
    n = split("foo:bar:baz", arr, ":");

    # Підтримуються асоціативні масиви (насправді, всі масиви асоціативні):
    assoc["foo"] = "bar";
    assoc["bar"] = "baz";

    # Та багатовимірні масиви (з деякими обмеженнями, які описуються далі):
    multidim[0,0] = "foo";
    multidim[0,1] = "bar";
    multidim[1,0] = "baz";
    multidim[1,1] = "boo";

    # Можна перевірити членство в масиві:
    if ("foo" in assoc)
        print "Fooey!";

    # Оператор 'in' також можна використовувати для обходу ключів масиву:
    for (key in assoc)
        print assoc[key];

    # Командний рядок знаходиться у спеціальному масиві з ім'ям ARGV
    for (argnum in ARGV)
        print ARGV[argnum];

    # Можна видаляти елементи масиву. Це особливо корисно для того, щоб AWK
    # не розглядав аргументи як імена файлів для обробки
    delete ARGV[1];

    # Кількість аргументів командного рядка міститься у змінній з іменем ARGC
    print ARGC;

    # AWK має багато вбудованих функцій. Вони діляться на три категорії, які
    # буде розглянуто далі.

    return_value = arithmetic_functions(a, b, c);
    string_functions();
    io_functions();
}

# Функції декларуються так:
function arithmetic_functions(a, b, c,     d) {

    # Однією з дратівливих особливостей AWK є те, що в цій мові немає
    # локальних змінних. Усе є глобальним.
    # Для коротких сценаріїв це добре, навіть корисно, але для довших
    # сценаріїв це може бути проблемою.

    # Проте, є обхідний шлях (huk). Вказані у функції аргументи є локальними
    # у функції. Крім того, AWK дозволяє вказувати більше аргументів функції,
    # ніж потрібно. Тому, просто вставте локальну змінну в оголошення
    # функції, як це зроблено вище. Можна додати також додаткові пробіли,
    # щоб відрізнити фактичні параметри функції від створених у такий спосіб
    # локальних змінних.
    # У наведеному вище прикладі, змінні a, b, c є фактичними параметрами,
    # тоді як d є лише локальною змінною.

    # Тепер, розглянемо математичні функції

    # Більшість реалізацій AWK підтримують стандартні тригонометричні функції:
    localvar = sin(a);
    localvar = cos(a);
    localvar = atan2(b, a); # арктангенс b / a

    # та логаритмічні обчислення:
    localvar = exp(a);
    localvar = log(a);

    # квадратний корінь:
    localvar = sqrt(a);

    # округлення до цілого числа:
    localvar = int(5.34); # localvar => 5

    # випадкові числа:
    srand(); # встановити т.зв. "сіль" (без аргумента використовується час)
    localvar = rand(); # випадкове число від 0 до 1.

    # Повернути значення можна так:
    return localvar;
}

# Функції для обробки рядків тексту
function string_functions(    localvar, arr) {

    # AWK, як мова обробки тексту, підтримує функції для обробки рядків.
    # У багатьох з цих функцій використовуються регулярні вирази.

    # Пошук і заміна, першої (sub) або всіх відповідностей (gsub).
    # Обидві вони повертають кількість замінених відповідностей.
    localvar = "fooooobar";
    sub("fo+", "Meet me at the ", localvar); # localvar => "Meet me at the bar"
    gsub("e", ".", localvar); # localvar => "m..t m. at th. bar"

    # Пошук підрядка, який збігається з регулярним виразом:
    # index() робить те ж саме, але не використовує регулярний вираз.
    match(localvar, "t"); # => 4, оскільки 't' є четвертим символом

    # Розбити рядок за роздільником
    n = split("foo-bar-baz", arr, "-"); # a[1] = "foo"; a[2] = "bar"; a[3] = "baz"; n = 3

    # Інші корисні речі
    sprintf("%s %d %d %d", "Testing", 1, 2, 3); # => "Testing 1 2 3"
    substr("foobar", 2, 3); # => "oob"
    substr("foobar", 4); # => "bar"
    length("foo"); # => 3
    tolower("FOO"); # => "foo"
    toupper("foo"); # => "FOO"
}

# Функції введення-виведення
function io_functions(    localvar) {

    # Ви вже бачили print
    print "Hello world";

    # Є також printf
    printf("%s %d %d %d\n", "Testing", 1, 2, 3);

    # AWK сам по собі не має дескрипторів файлів. Він автоматично відкриває
    # дескриптор файлу, коли виконується дія, яка потребує дискриптора.
    # Рядок, який використано для цього, можна розглядати як дескриптор файлу
    # для введення-виводу. Це схоже на сценарії оболонки.
    # Рядок, при цьому, повинен точно збігатися. Тому використовуйте змінну:
    outfile = "/tmp/foobar.txt";
    print "foobar" > outfile;

    # Тепер, рядок вихідного файлу є дескриптором файлу.
    # Ви можете закрити його:
    close(outfile);

    # Ось як запустити команду в оболонці
    system("echo foobar"); # => друкує foobar

    # Читає рядок із потоку стандартного введення та зберігає в localvar
    getline localvar;

    # Читає рядок з каналу (використовуйте рядок, щоб правильно його закрити)
    cmd = "echo foobar";
    cmd | getline localvar; # localvar => "foobar"
    close(cmd);

    # Читає рядок з файлу та зберігає в localvar
    infile = "/tmp/foobar.txt";
    getline localvar < infile;
    close(infile);
}

# Як вже вказувалося, програми AWK складаються з набору шаблонів та дій.
# Було розглянуто шаблони BEGIN та END . Інші шаблони використовуються тоді,
# коли скрипт обробляє рядки з файлів або стандартного потоку введення.
#

# Вказані у командному рядку аргументи розглядаються як імена файлів для
# обробки. Усі ці файли обробляються послідовно один за одним.
# Виконується неявний цикл, в якому обробляються усі рядки з цих файлів.
# Шаблони та дії AWK схожі на оператор switch всередині циклу.

/^fo+bar$/ {
    # Ця дія буде виконуватися для кожного рядка, який збігається з регулярним
    # виразом: /^fo+bar$/, і буде пропущена для усіх рядків,
    # які не збігаються з ним. Давайте просто надрукуємо рядок:

    print;

    # Без аргументів! Це тому, що print має аргумент за замовчуванням: $0.
    # $0 - ім'я змінної, яка містить увесь поточний рядок. Ця змінна
    # створюється автоматично.

    # Також існують інші змінні зі знаком $. Кожен рядок неявно розбивається
    # перед викликом кожної дії так, як це робить оболонка. І так само, як і
    # в оболонці, до кожного поля можна отримати доступ із відповідної змінної
    # зі знаком долара.

    # Тут буде виведене друге та четверте поля з рядка
    print $2, $4;

    # AWK автоматично визначає багато інших змінних, щоб допомогти перевірити
    # та обробити кожен рядок. Однією з них є NF.

    # Друкує кількість полів у цьому рядку
    print NF;

    # Друк останнього поля у цьому рядку
    print $NF;
}

# Кожен шаблон є логічним виразом. Регулярний вираз у наведеному шаблоні
# також є перевіркою на істине/хибне, але частина виразу прихована.
# Шаблон обробляє кожен вхідний рядок і його повна версія є такою:
$0 ~ /^fo+bar$/ {
    print "Equivalent to the last pattern";
}

a > 0 {
    # цей блок виконуватиметься для кожного рядка, допоки змінна a буде
    # більшою від 0
}

# Ідея AWK зрозуміла. Обробка текстових файлів, порядкове зчитування і
# обробка, зокрема розбиття за роздільником, настільки поширені в UNIX,
# що AWK — це мова сценаріїв, яка виконує все це сама, без ваших вказівок.
# Все, що вам потрібно зробити, це написати шаблони та дії на основі того,
# що ви очікуєте від введення, і що ви хочете з ним зробити.

# Ось короткий приклад простого сценарію, для якого чудово підходить AWK.
# Цей сценарій прочитає ім’я зі стандартного потоку введення, а потім надрукує
# середній вік для людей з цим іменем.
# Нехай, як аргумент скрипта вказано ім’я файла з такими даними:
#
# Bob Jones 32
# Jane Doe 22
# Steve Stevens 83
# Bob Smith 29
# Bob Barker 72
#

# Ось сценарій:

BEGIN {

    # Спершу попросимо користувача ввести ім'я
    print "What name would you like the average age for?";

    # Отримати рядок зі стандартного потоку введення, а не з файлів
    # командного рядка
    getline name < "/dev/stdin";
}

# Тепер обробимо кожен рядок, першим полем якого є вказане ім'я
$1 == name {

    # Тут усередині ми маємо доступ до низки корисних змінних, які вже
    # встановлені для нас попередньо:
    # $0 - це весь рядок
    # $3 - це третє поле, вік, який нас тут цікавить
    # NF - це кількість полів, яка має бути 3
    # NR - це кількість записів (рядків), переглянутих на поточний момент
    # FILENAME - ім'я файла, який обробляється
    # FS - це роздільник полів, який використовується. Тут це - " "
    # ...  є багато інших задокументованих на сторінці керівництва змінних

    # Обчислимо поточну суму та кількість рядків, які відповідають шаблону
    sum += $3;
    nlines++;
}

# Ще один спеціальний шаблон називається END. Він виконується після обробки
# всіх текстових файлів. На відміну від BEGIN, він запуститься, якщо були
# дані для обробки. Він виконуватиметься після того, як будуть прочитані та
# оброблені, відповідно до вказаних правил та дій, усі файли з вхідними даними.
# Його мета зазвичай полягає в тому, щоб вивести якийсь остаточний звіт або
# зробити щось із накопиченою протягом сценарію сукупністю даних

END {
    if (nlines)
        print "The average age for " name " is " sum / nlines;
}

